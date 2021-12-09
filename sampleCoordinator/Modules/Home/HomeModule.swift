//
//  HomeModule.swift
//  sampleCoordinator
//
//  Created by mohebro on 09.12.2021.
//

import UIKit

protocol HomeModuleDelegate: Presentable {
    var onDetais: ((TodoItem) -> ())? { get set }
}

struct HomeModule {
    
    func build() -> HomeModuleDelegate {
        let view = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeView") as! HomeView
        let presenter = HomePresenter()
        view.presenter = presenter
        presenter.view = view
        return presenter
    }
}
