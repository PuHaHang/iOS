import FirebaseMessaging
import Foundation
import Minifire

struct FCMTokenService {
    func loadToken() async throws -> String {
        try await Messaging.messaging().token()
    }
    
    func update(token: String, for userToken: String) async throws {
        let request = MFRequest(url: "http://121.157.24.40/api/v1/user/fcm-token")
            .patch()
            .validate()
            .addHeaders([.authorization(bearerToken: userToken)])
            .addParameters(["fcmToken": token])
        
        try await MF
            .setErrorDecoder(LoginDecoder.shared)
            .request(request)
    }
}
