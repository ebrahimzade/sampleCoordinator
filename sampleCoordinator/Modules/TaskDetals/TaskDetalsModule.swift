//
//  TaskDetalsModule.swift
//  sampleCoordinator
//
//  Created by mohebro on 09.12.2021.
//

import UIKit

protocol TaskDetalsModuleDelegate: Presentable {
    var dismissClosure: (() -> ())? { get set }
}

struct TaskDetalsModule {
    
    func build(item: TodoItem) -> TaskDetalsModuleDelegate {
        let view = UIStoryboard(name: "TaskDetals", bundle: nil).instantiateViewController(withIdentifier: "TaskDetalsView") as! TaskDetalsView
        let presenter = TaskDetalsPresenter(item: item)
        view.presenter = presenter
        presenter.view = view
        return presenter
    }
}
