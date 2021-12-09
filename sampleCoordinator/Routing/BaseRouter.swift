//
//  BaseRouter.swift
//  sampleCoordinator
//
//  Created by mohebro on 09.12.2021.
//

import Foundation

class BaseRouter: NSObject, Router {

    var childRouters: [Router] = []

    func start() {
    }

    func restart() {
        removeAllDependencies()
        start()
    }

    func addDependency(_ router: Router) {
        for element in childRouters {
            if element === router { return }
        }
        childRouters.append(router)
    }

    func removeDependency(_ router: Router?) {
        guard
            childRouters.isEmpty == false,
            let router = router
            else { return }

        for (index, element) in childRouters.enumerated() {
            if element === router {
                childRouters.remove(at: index)
                break
            }
        }
    }

    func removeAllDependencies() {
        childRouters.removeAll()
    }

}
