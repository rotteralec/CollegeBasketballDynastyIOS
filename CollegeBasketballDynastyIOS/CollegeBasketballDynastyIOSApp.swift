//
//  CollegeBasketballDynastyIOSApp.swift
//  CollegeBasketballDynastyIOS
//
//  Created by Al Rotter on 7/14/25.
//

import SwiftUI
import SwiftData

@main
struct CollegeBasketballDynastyIOSApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
