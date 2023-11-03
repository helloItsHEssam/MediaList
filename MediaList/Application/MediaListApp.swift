//
//  MediaListApp.swift
//  MediaList
//
//  Created by Hessam Mahdiabadi on 11/1/23.
//

import SwiftUI

@main
struct MediaListApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            MediaListView()
        }
    }
}
