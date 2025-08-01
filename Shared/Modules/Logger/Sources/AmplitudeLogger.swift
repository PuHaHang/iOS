import AmplitudeSwift
import Foundation

public final class AmplitudeLogger: Logger {
    public static let shared = AmplitudeLogger()
    
    private let instance: Amplitude
    
    private let amplitudeKey: String = {
        let loggerBundle = Bundle(for: AmplitudeLogger.self)
        return loggerBundle.object(forInfoDictionaryKey: "AMPLITUDE_API_KEY") as? String ?? ""
    }()
    
    private init() {
        print(">>> Amplitude API Key: \(amplitudeKey)")
        
         self.instance = Amplitude(
             configuration: Configuration(
                 apiKey: amplitudeKey,
                 autocapture: .appLifecycles
             )
         )
    }
    
    public func track(_ event: LogEvent) {
        let item = event.item
        var type: String = ""
        
        switch item.type {
        case .screen(let screenName):
            type = "Screen - \(screenName)"
        case .buttonClick(let screenName, let buttonName):
            type = "Tap - \(screenName)_\(buttonName)"
        case .voiceRecognition(let recognizedString):
            type = "Voice - \(recognizedString)"
        }
        
        self.track(
            type,
            message: item.message,
            parameters: item.properties ?? [:]
        )
    }
    
    private func track(_ eventType: String, message: String?, parameters: [String: Any]) {
        var properties = parameters
        
        if let message {
            properties["message"] = message
        }
        
        let event = BaseEvent(
            eventType: eventType,
            eventProperties: properties
        )
        
        instance.track(event: event)
    }
}
