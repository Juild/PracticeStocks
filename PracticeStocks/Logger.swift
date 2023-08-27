//
//  Logger.swift
//  PracticeStocks
//
//  Created by Jc on 16/8/23.
//

import os

protocol Logging {
    var logger: Logger {get}
}
extension Logging {
    var logger: Logger {return  Logger() }
}
