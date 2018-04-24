//
//  User.swift
//  buynothing
//
//  Created by Jake Romer on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import CloudKit
import Foundation

struct User {
    let emailAddress: String
    let id: Int
    let firstName: String
    let lastInitial: String
    var latitude: Double?
    var longitude: Double?

    // TEMPORARY
    static var testUser: User {
        return User(json: ["email": "juner@gmail.com" as AnyObject,
                           "id": 39_393 as AnyObject,
                           "first_name": "June" as AnyObject,
                           "last_name": "R" as AnyObject])!
    }

    init?(json: [String: AnyObject]) {
        guard let emailAddress = json["email"] as? String,
            let id = json["id"] as? Int,
            let firstName = json["first_name"] as? String,
            let lastInitial = json["last_name"] as? String
            else { return nil }

        self.emailAddress = emailAddress
        self.id = id
        self.firstName = firstName
        self.lastInitial = lastInitial
    }

    /// Generate a CKRecord representation of user to allow
    /// persisting to CloudKit
    func toRecord() -> CKRecord? {
        let record = CKRecord(recordType: "Users")
        record["emailAddress"] = emailAddress as CKRecordValue
        return record
    }
}
