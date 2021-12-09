//
//  ApplicationRouter.swift
//  sampleCoordinator
//
//  Created by mohebro on 09.12.2021.
//

import Foundation

import UIKit

typealias MainNavigationController = UINavigationController

protocol AppRouterInterface: Router {}

final class ApplicationRouter: BaseRouter, AppRouterInterface {
    
    let navigationHandler: NavigationHandler

    init(navigationHandler: NavigationHandler) {
        self.navigationHandler = navigationHandler
    }

    override func start() {
        self.startHomeModule()
    }

    private func startHomeModule() {
        let module = HomeModule().build()
        
        module.onDetais = {[weak self] item in
            self?.showDetailsModule(item: item)
        }

        navigationHandler.setRootModule(module)
    }
    
    private func showDetailsModule(item: TodoItem) {
        let module = TaskDetalsModule().build(item: item)

        module.dismissClosure = {[weak self] in
            self?.navigationHandler.popModule()
        }
        
        navigationHandler.push(module)
    }
    
    private func start(testModule: Presentable) {
        self.navigationHandler.setRootModule(testModule)
    }

}
