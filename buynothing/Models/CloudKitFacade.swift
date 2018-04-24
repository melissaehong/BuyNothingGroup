//
//  CloudKitFacade.swift
//  buynothing
//
//  Created by Jake Romer on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import CloudKit

typealias RecordCompletion = (CKRecord?) -> Void
typealias CollectionCompletion = ([CKRecord]?) -> Void

// TODO: Check if user is logged into icloud. If not, prompt them to.

struct CloudKitFacade {
    static let shared = CloudKitFacade()
    private init() {}

    let container = CKContainer.default()

    var publicDatabase: CKDatabase {
        return container.publicCloudDatabase
    }

    /// Save LISTING to CloudKit public database,
    /// yield success boolean to COMPLETION handler.
    func saveListing(_ listing: Listing, completion: @escaping RecordCompletion) {
        let completeInMain = {(record: CKRecord?) -> Void in
            OperationQueue.main.addOperation { completion(record) }
        }

        OperationQueue().addOperation {
            do {
                if let record = try listing.toRecord() {
                    self.publicDatabase.save(record) { (record, error) in
                        // TODO: Add error handling
                        guard error == nil, record != nil else {
                            return completeInMain(nil)
                        }
                        return completeInMain(record)
                    }
                }
            } catch {
                // TODO: Add error handling for record not being created
                return completeInMain(nil)
            }
        }
    }

    /// Query CloudKit public database for listings,
    /// yield success boolean to COMPLETION handler.
    func getListings(matchingTerms searchTerms: [String]? = nil,
                     completion: @escaping CollectionCompletion) {

        let completeInMain = { (records: [CKRecord]?) in
            OperationQueue.main.addOperation { completion(records) }
        }

        let predicate: NSPredicate
        if let searchTerms = searchTerms {
            predicate = NSPredicate(format: "self contains %@", argumentArray: searchTerms)
        } else {
            predicate = NSPredicate(value: true)
        }

        OperationQueue().addOperation {
            let query = CKQuery(recordType: "Listings", predicate: predicate)
            self.publicDatabase.perform(query, inZoneWith: nil) { (records, error) in
                if error != nil { return completeInMain(nil) }
                guard let records = records else { return completeInMain(nil) }
                completeInMain(records)
            }
        }
    }
}
