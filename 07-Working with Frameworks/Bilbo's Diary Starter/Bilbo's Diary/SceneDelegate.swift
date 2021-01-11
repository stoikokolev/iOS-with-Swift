//
//  SceneDelegate.swift
//  My Location
//
//  Created by Veronica Velkova on 27.09.20.
//

import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    // TODO: - Implement CoreData Stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores {
            storeDescription, error in
            if let error = error {
                fatalError("Could not load data store: \(error)")
            }
        }
        
        return container
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = persistentContainer.viewContext
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        customizeAppearance()
        
        // TODO: - Implement Dependency Injection for managedObjectContext
        let tabBarController = window!.rootViewController as! UITabBarController
       
        // first item
        let firstNavigationController = tabBarController.viewControllers![0] as! UINavigationController
        let controller = firstNavigationController.viewControllers[0] as! CurrentLocationViewController
        controller.managedObjectContext = managedObjectContext
        
        // second item
        let secondNavigationController = tabBarController.viewControllers![1] as! UINavigationController
        let locationsController = secondNavigationController.viewControllers[0] as! LocationsViewController
        locationsController.managedObjectContext = managedObjectContext
        
        // third item
        let thirdNavigationController = tabBarController.viewControllers![2] as! UINavigationController
        let mapsController = thirdNavigationController.viewControllers[0] as! MapViewController
        mapsController.managedObjectContext = managedObjectContext
    }
    
    func customizeAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor(named: "NavigationColor")
        UINavigationBar.appearance().tintColor = UIColor(named: "ButtonColor")
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:
                UIColor(named: "TextColor")!,
            NSAttributedString.Key.font:
                UIFont(name: "RingbearerMedium", size: 18.0) ?? .systemFont(ofSize: 16)]
        
        // TODO: - Implement appearance for tab bar
        UITabBar.appearance().barTintColor = UIColor(named: "NavigationColor")
        UITabBar.appearance().tintColor = UIColor(named: "ButtonColor")
        
    }
}

