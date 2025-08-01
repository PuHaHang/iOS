import ComposableArchitecture
import Presentation
import UIKit
import SwiftUI

@main
struct PuHaHangApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    static let store = Store(initialState: SplashReducer.State()) {
        SplashReducer()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView(store: PuHaHangApp.store)
        }
    }
}
