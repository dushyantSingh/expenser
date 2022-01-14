//
//  ExpenseDB.swift
//  Expenser
//
//  Created by Dushyant Singh on 11/1/22.
//

import Foundation
import RealmSwift

class ExpenseDB: RealmDbType {
    var dbName: String { "ExpenseDB" }
    var schemaVersion: UInt64 { 1 }
    var objectTypes: [Object.Type] {[ExpenseObject.self]}
    var realm: Realm?

    static let shared: ExpenseDB = ExpenseDB()
    private init() {
        self.initializeDB { success, _ in
            if !success {
                print("ExpenseDB failed to initialize")
            }
        }
    }
}
