//
//  ModelsProtocol.swift
//  PracticeStocks
//
//  Created by Jc on 16/8/23.
//

import Foundation

protocol ModelProtocol {
    associatedtype VM
    func toVM() -> VM
}
