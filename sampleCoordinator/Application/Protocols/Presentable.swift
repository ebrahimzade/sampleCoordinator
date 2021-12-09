//
//  Presentable.swift
//  sampleCoordinator
//
//  Created by mohebro on 09.12.2021.
//

import UIKit.UIViewController

protocol Presentable: class {
    func presentingView() -> UIViewController
}

extension UIViewController: Presentable {

    func presentingView() -> UIViewController {
        return self
    }

}
