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
    let deleteTriggered = PublishSubject<IndexPath>()
    let events = PublishSubject<Event>()

    private let disposeBag = DisposeBag()
    init(service: ExpenseServiceType) {
        expenseService = service
        fetchAllExpenses()
        setupDelete()
        setupDatabaseChanges()
    }
}

private extension AllExpenseViewModel {
    func setupDatabaseChanges() {
        expenseService.changesObserved.asObservable()
            .subscribe(onNext: { [weak self]_ in
                self?.fetchAllExpenses()
            })
            .disposed(by: disposeBag)
    }

    func fetchAllExpenses() {
        expenseSections.removeAll()
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

    func setupDelete() {
        deleteTriggered.asObservable()
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }

                let expense = self.expenseSections[indexPath.section].rows.remove(at: indexPath.row)
                self.expenseService.deleteExpense(expense)
            })
            .disposed(by: disposeBag)
    }
}
