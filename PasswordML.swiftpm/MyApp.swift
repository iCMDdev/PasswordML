import SwiftUI

@main
struct MyApp: App {
    @StateObject var settings = Settings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(settings.colorSchemeSetting == .system ? nil : (settings.colorSchemeSetting == .light ? ColorScheme.light : ColorScheme.dark))
                .environmentObject(settings)
        }
    }
}
