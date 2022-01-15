//
//  ExpenseObject.swift
//  Expenser
//
//  Created by Dushyant Singh on 11/1/22.
//

import Foundation
import RealmSwift
import RxSwift

class ExpenseObject: Object {
    @Persisted var creationDate: Date = Date()
    @Persisted var expenseDate: Date = Date()
    @Persisted var title = ""
    @Persisted var amount: Double = 0.00
    @Persisted var currency: String = "SGD"
    @Persisted var currencySymbol: String = "$"
}
