//
//  AllExpenseViewModel.swift
//  Expenser
//
//  Created by Dushyant Singh on 11/1/22.
//

import Foundation

import Foundation
import RxCocoa
import RxSwift

class AllExpenseViewModel {
    enum Event {
        case deleteExpense(ExpenseObject)
    }

    var expenseSections = [ExpenseSectionModel]()

    let expenseService: ExpenseServiceType
    let events = PublishSubject<Event>()

    init(service: ExpenseServiceType) {
        expenseService = service
        fetchAllExpenses()
    }
}

private extension AllExpenseViewModel {
    func fetchAllExpenses() {
        var expenses = expenseService.getAllExpenses()
        expenses.sort { $0.expenseDate > $1.expenseDate }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        let groupedExpenses = Dictionary(grouping: expenses) {formatter.string(from:$0.expenseDate)}
        groupedExpenses.forEach { key, value in
            let section = ExpenseSectionModel(header: key, rows: value)
            expenseSections.append(section)
        }
        expenseSections.sort { formatter.date(from: $0.header)! > formatter.date(from: $1.header)! }
    }
}
