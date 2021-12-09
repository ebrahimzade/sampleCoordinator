//
//  DatabaseManager.swift
//  sampleCoordinator
//
//  Created by mohebro on 09.12.2021.
//

import Foundation

protocol DatabaseManager {
    func fetchAllItems(completion: (([TodoItem]) -> Void)?)
    func addNewItem(completion: ((TodoItem) -> Void)?)
    func save()
    func delete(item: TodoItem)
}
