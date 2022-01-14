//
//  ExpenseService.swift
//  Expenser
//
//  Created by Dushyant Singh on 11/1/22.
//

import Foundation

protocol ExpenseServiceType {
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
