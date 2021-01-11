//
//  AppDelegate.swift
//  My Location
//
//  Created by Veronica Velkova on 27.09.20.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let applicationDocumentsDirectory: URL = {
      let paths = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
      return paths[0]
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(applicationDocumentsDirectory)
        return true
    }

}

