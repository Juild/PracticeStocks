//
//  UserDefaultsReadWrite.swift
//  PracticeStocks
//
//  Created by Jc on 22/8/23.
//

import Foundation

class AppUserDefaults {
    static let userDefaults = UserDefaults.standard
    static func read<T>(type: T, forKey: String) -> Result<Void, Error> {
        userDefaults.data(forKey: <#T##String#>)
    }
    
}
