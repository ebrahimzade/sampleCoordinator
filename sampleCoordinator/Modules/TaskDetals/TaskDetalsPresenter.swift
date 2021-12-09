//
//  TaskDetalsPresenter.swift
//  sampleCoordinator
//
//  Created by mohebro on 09.12.2021.
//

import UIKit

protocol TaskDetalsPresenterInterface {
    func viewDidLoad()
}

class TaskDetalsPresenter: NSObject {
    weak var view: TaskDetalsViewInterface!
    var dismissClosure: (() -> ())?

    //MARK: -
    let database: DatabaseManager
    var item: TodoItem
    init(item: TodoItem, database: DatabaseManager = CoreDataManager.shared) {
        self.database = database
        self.item = item
    }
    
    deinit {
        removeObserver()
    }
    
}

extension TaskDetalsPresenter: TaskDetalsModuleDelegate {
    func presentingView() -> UIViewController {
        return view
    }
}

extension TaskDetalsPresenter: TaskDetalsPresenterInterface {
    
    func viewDidLoad() {
        setupViewBindings()
        view.initialSetup()
        observeInactiveStatus()
        setInitialValues()
    }
    
    private func setInitialValues() {
        view.set(title: item.title ?? "")
        view.set(detail: item.detail ?? "")
    }
    
    private func setupViewBindings() {
        view.onViewWillDisappear = {[weak self] in
            self?.saveChanges()
        }
        
        view.onDelete = {[weak self] in
            self?.database.delete(item: self!.item)
            self?.dismissClosure?()
        }
        
        view.onTitleChanged = {[weak self] text in
            self?.item.title = text
        }
        
        view.onDetailChanged = {[weak self] text in
            self?.item.detail = text
        }
    }
    
    @objc private func saveChanges() {
        self.database.save()
    }
    
    private func observeInactiveStatus() {
        NotificationCenter.default.addObserver(self, selector: #selector(saveChanges), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    private func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
}
