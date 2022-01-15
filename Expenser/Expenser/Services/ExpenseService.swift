//
//  ExpenseService.swift
//  Expenser
//
//  Created by Dushyant Singh on 11/1/22.
//

import Foundation
import RxSwift

protocol ExpenseServiceType {
    var changesObserved: Observable<Void> { get }
    func getAllExpenses() -> [ExpenseObject]

    @discardableResult
    func addExpense(title: String, date: Date, amount: Double) -> Bool

    @discardableResult
    func deleteExpense(_ object: ExpenseObject) -> Bool
}

class ExpenseService: ExpenseServiceType {
    let expenseDB: RealmDbType

    init(expenseDB: RealmDbType) {
        self.expenseDB = expenseDB
    }

    var changesObserved: Observable<Void> {
        return expenseDB.changesObserved ?? .empty()
    }

    func getAllExpenses() -> [ExpenseObject] {
        return expenseDB.realmObjects(type: ExpenseObject.self) ?? []
    }

    func addExpense(title: String, date: Date, amount: Double) -> Bool {
        let expense = ExpenseObject()

        expense.currency = "SGD"
        expense.currencySymbol = "$"
        expense.creationDate = Date()

        expense.title = title
        expense.expenseDate = date
        expense.amount = amount
        expenseDB.save(object: expense)
        return true
    }

    func deleteExpense(_ object: ExpenseObject) -> Bool {
        if expenseDB.delete(object: object) == nil {
            return true
        }
        return false
    }
}
