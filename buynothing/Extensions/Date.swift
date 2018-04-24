//
//  Date.swift
//  buynothing
//
//  Created by Jake Romer on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import Foundation

extension Date {
  /**
   Return a String representation of the time object formatted
   according to the selected date and time styles.

   Style Examples:

   - Short: "11/23/37" or "3:30 PM"
   - Medium: "Nov 23, 1937" or "3:30:32 PM"
   - Long: "November 23, 1937" or "3:30:32 PM PST"
   - Full: "Tuesday, April 12, 1952 AD" or "3:30:42 PM Pacific Standard Time"

   - Parameter dateStyle: see Examples
   - Parameter timeStyle: see Examples

   - Returns: String
   */
  func toString(dateStyle: DateFormatter.Style = .medium,
                timeStyle: DateFormatter.Style = .none) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = dateStyle
    formatter.timeStyle = timeStyle
    return formatter.string(from: self)
  }

  /**
   Parse a string representation of a date into a Date object.
   By default, accepts date strings in the format returned by the
   GitHub API.

   Example:

   ```
   Date.fromString("2011-01-26T19:01:12Z")
   // Optional(2011-01-26 19:01:12 +0000)
   ```

   - Parameter dateString: a date string
   - Parameter dateFormat: a date format template string

   - Returns: Date?
   */
  static func fromString(_ dateString: String,
                         dateFormat: String = "yyyy-MM-dd") -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    return formatter.date(from: dateString)
  }
}
