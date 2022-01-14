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
    @objc dynamic var creationDate: Date = Date()
    @objc dynamic var expenseDate: Date = Date()
    @objc dynamic var title = ""
    @objc dynamic var amount: Double = 0.00
    @objc dynamic var currency: String = "SGD"
    @objc dynamic var currencySymbol: String = "$"
}
