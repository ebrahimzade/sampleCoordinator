//
//  HomeView.swift
//  sampleCoordinator
//
//  Created by mohebro on 09.12.2021.
//

import UIKit

protocol HomeViewInterface: Presentable {
    func initialSetup()
    func reloadData()
    
    var onDeleteItem: ((_ index: Int) -> ())? { get set }
    var onSelectItem: ((_ index: Int) -> ())? { get set }
    var onAddItem: (() -> ())? { get set }
    var onViewDidAppear: (() -> ())? { get set }
}

typealias HomeViewItem = StringRepresentable

class HomeView: UITableViewController {
    var onAddItem: (() -> ())?
    var onDeleteItem: ((Int) -> ())?
    var onSelectItem: ((Int) -> ())?
    var onViewDidAppear: (() -> ())?
    
    var presenter: HomePresenterInterface!
    
    // MARK: - Properties
    private let tableViewCellIdentifier = "TodoCell"
    var items: [StringRepresentable] { presenter.items }
            
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onViewDidAppear?()
    }

    // MARK: - Setups

    private func setupTableView() {
        tableView.allowsMultipleSelection = false
        tableView.allowsSelection = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
    }
    
    // MARK: - Actions

    @IBAction func addItemAction(_ sender: Any) {
        onAddItem?()
    }
    
}



extension HomeView: HomeViewInterface {
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func initialSetup() {
        self.navigationItem.title = "Todo List"
        
        setupTableView()
    }
    
}

// MARK: - TableView

extension HomeView {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].stringValue
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            onDeleteItem?(indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelectItem?(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
