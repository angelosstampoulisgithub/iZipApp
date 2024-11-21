//
//  iZipAppApp.swift
//  iZipApp
//
//  Created by Angelos Staboulis on 19/11/24.
//

import SwiftUI

@main
struct iZipAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 450, height: 320)
                .windowResizeBehavior(.disabled)
        } .windowResizability(.contentSize)
    }
}
