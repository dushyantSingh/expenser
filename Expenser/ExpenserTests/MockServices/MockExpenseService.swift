//
//  MockExpenseService.swift
//  ExpenserTests
//
//  Created by Dushyant Singh on 15/1/22.
//

import Foundation
import RxSwift

@testable import Expenser

class MockExpenseService: ExpenseServiceType {
    var changesObserved: Observable<Void> {
        return .empty()
    }


    var stubExpenses = [ExpenseSectionModel]()
    func getAllExpenses() -> [ExpenseSectionModel] {
        return stubExpenses
    }

    var addExpenseCalledWithTitle: String?
    var addExpenseCalledWithDate: Date?
    var addExpenseCalledWithAmount: Double?
    func addExpense(title: String, date: Date, amount: Double) -> Bool {
        addExpenseCalledWithTitle = title
        addExpenseCalledWithDate = date
        addExpenseCalledWithAmount = amount
        return true
    }

    func deleteExpense(_ object: ExpenseObject) -> Bool {
        return true
    }
}
