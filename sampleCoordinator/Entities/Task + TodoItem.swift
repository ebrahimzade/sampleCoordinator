//
//  Task + TodoItem.swift
//  sampleCoordinator
//
//  Created by mohebro on 09.12.2021.
//

import Foundation

extension Task: TodoItem {
    var stringValue: String { title ?? "untitled" }

}
