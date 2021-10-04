//
//  IGMapsApp.swift
//  IGMaps
//
//  Created by Lucas Alexandre Amorim Leoncio on 04/10/21.
//

import SwiftUI
import GoogleMaps

@main
struct IGMapsApp: App {
    
    init() {
        GMSServices.provideAPIKey("AIzaSyDbuFgbaOeKIMcGk55F2zGYWcJh4Z5zpYU")
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
