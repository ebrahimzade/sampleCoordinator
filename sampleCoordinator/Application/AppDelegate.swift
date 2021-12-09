//
//  AppDelegate.swift
//  sampleCoordinator
//
//  Created by mohebro on 09.12.2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private lazy var mainNavigationController = UINavigationController()
    private lazy var applicationRouter: AppRouterInterface = produceApplicationRouter()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        startCoordinator()
        
        return true
    }
    
    private func startCoordinator() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.mainNavigationController
        self.window?.makeKeyAndVisible()
        self.applicationRouter.start()
    }
    
    private func produceApplicationRouter() -> AppRouterInterface {
        let navigationHandler = MainNavigationHandler(rootController: mainNavigationController)

        return ApplicationRouter(navigationHandler: navigationHandler)
    }
}

