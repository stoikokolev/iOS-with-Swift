//
//  SceneDelegate.swift
//  Checklist
//
//  Created by Stoyko Kolev on 18.09.20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let dataModel = DataModel()
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
         options connectionOptions: UIScene.ConnectionOptions) {
      let navigationController = window!.rootViewController
                                 as! UINavigationController
      let controller = navigationController.viewControllers[0]
                       as! AllListsViewController
      controller.dataModel = dataModel
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        saveData()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        saveData()
    }

    // MARK:- Helper Methods
    func saveData() {
        dataModel.saveChecklists()
    }
}

