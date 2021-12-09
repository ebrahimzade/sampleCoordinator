//
//  HomePresenter.swift
//  sampleCoordinator
//
//  Created by mohebro on 09.12.2021.
//

import UIKit

protocol TodoItem: HomeViewItem {
    var title: String? { get set }
    var detail: String? { get set }
}

protocol HomePresenterInterface {
    func viewDidLoad()
    
    var items: [HomeViewItem] { get }
}

class HomePresenter: NSObject {
    weak var view: HomeViewInterface!
    var onDetais: ((TodoItem) -> ())?
    
    var todoItems: [TodoItem] = []

    //MARK: -
    let database: DatabaseManager
    init(database: DatabaseManager = CoreDataManager.shared) {
        self.database = database
    }
}

extension HomePresenter: HomeModuleDelegate {
    func presentingView() -> UIViewController {
        return view.presentingView()
    }
}

extension HomePresenter: HomePresenterInterface {
    var items: [HomeViewItem] { todoItems }
    
    func viewDidLoad() {
        setupViewBindings()
        view.initialSetup()
    }
    
    private func setupViewBindings() {
        view.onViewDidAppear = { [weak self] in
            guard let self = self else { return }
            self.getData()
        }
        
        view.onAddItem = {[weak self] in
            self?.addNewItem()
        }
        
        view.onSelectItem = {[weak self] index in
            guard let self = self else { return }
            
            let item = self.todoItems[index]
            self.showItemDetails(for: item)
        }
        
        view.onDeleteItem = {[weak self] index in
            guard let self = self else { return }

            self.deleteItem(at: index)
        }
    }
    

    private func getData() {
//        self.todoItems = ["Laundry", "Exercise", "Shopping"]
        database.fetchAllItems { [weak self] items in
            guard let self = self else { return }
            self.todoItems = items
            self.view.reloadData()
        }
    }
    
    private func addNewItem() {
        //TODO: add new item and show details
        print("addNewItem selected")
        database.addNewItem {[weak self] newItem in
            guard let self = self else { return }
            self.onDetais?(newItem)
        }
        
    }
    
    private func showItemDetails(for item: TodoItem) {
        //TODO:
        self.onDetais?(item)
        print("showItemDetails selected for item \(item)")
    }
    
    private func deleteItem(at index: Int) {
        //TODO:
        print("deleteItem selected for index \(index)")
        self.todoItems.remove(at: index)
        self.view.reloadData()
    }

}
