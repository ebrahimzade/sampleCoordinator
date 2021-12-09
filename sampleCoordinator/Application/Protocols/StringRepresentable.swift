//
//  StringRepresentable.swift
//  sampleCoordinator
//
//  Created by mohebro on 09.12.2021.
//

import Foundation

protocol StringRepresentable {
    var stringValue: String { get }
}

extension String: StringRepresentable {
    var stringValue: String { self }
}
