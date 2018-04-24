//
//  String.swift
//  buynothing
//
//  Created by Jake Romer on 4/12/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import Foundation

extension String {
  /**
     Return all matches of the given REGEX in SELF.
     
     Examples:
     ```
     "hello mother hello father".scan("[:word:]{2}ther")
     
     [String] = 2 values {
     [0] = "mother"
     [1] = "father"
     }
     ```
     
     - Parameter regex: a String representation of a regular expression
     
     - Returns: [String] matches
   */
    func scan(_ regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("Invalid regular expression: \(error.localizedDescription)")
            return []
        }
    }
}
