//
//  UtilityFunctions.swift
//  PracticeStocks
//
//  Created by Jc on 27/8/23.
//

import Foundation

func camelCaseToNaturalLanguage(_ input: String) -> String {
    var result = ""

    for char in input {
        if char.isUppercase {
            result.append(" ")
        }
        result.append(char)
    }

    let formattedResult = result.prefix(1).uppercased() + result.dropFirst()

    return formattedResult
}
