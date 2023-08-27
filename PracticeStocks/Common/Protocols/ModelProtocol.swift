//
//  ModelProtocol.swift
//  PracticeStocks
//
//  Created by Jc on 22/8/23.
//

import Foundation

protocol Model {
    associatedtype VM
    func toVM() -> VM
}
