import ComposableArchitecture
import SwiftUI

@main
struct PuHaHangApp: App {
    static let store = Store(initialState: SplashReducer.State()) {
        SplashReducer()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView(store: PuHaHangApp.store)
        }
    }
}
