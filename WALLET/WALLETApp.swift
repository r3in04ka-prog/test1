import SwiftUI

@main
struct WALLETApp: App {
    @StateObject private var appState = AppState()
    var body: some Scene {
        WindowGroup { RootView().environmentObject(appState) }
    }
}
