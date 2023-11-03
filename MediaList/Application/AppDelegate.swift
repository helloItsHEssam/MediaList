//
//  AppDelegate.swift
//  MediaList
//
//  Created by Hessam Mahdiabadi on 11/3/23.
//

import UIKit
import MediaListFont

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        MediaListFont.registerFonts()
        
        return true
    }
}
