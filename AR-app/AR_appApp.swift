//
//  AR_appApp.swift
//  AR-app
//
//  Created by conganhhcmus on 10/06/2021.
//

import SwiftUI

@main
struct AR_appApp: App {
    @StateObject var placementSettings = PlacementSettings()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(placementSettings)
        }
    }
}
