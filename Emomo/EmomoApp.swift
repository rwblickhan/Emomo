//
//  EmomoApp.swift
//  Emomo
//
//  Created by Russell Blickhan on 9/29/20.
//

import SwiftUI

@main
struct EmomoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabView {
                WorkoutsView()
                    .tabItem {
                        Text(NSLocalizedString("Workouts", comment: "Title of the workouts tab"))
                        Image(systemName: "house")
                    }
                Text("Timer")
                    .tabItem {
                        Text(NSLocalizedString("Timer", comment: "Title of the timer tab"))
                        Image(systemName: "timer")
                    }
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
