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

    var expenseSections = BehaviorRelay(value: [ExpenseSectionModel]())

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
        var expenses = expenseService.getAllExpenses()
        expenseSections.accept(expenses)
    }

    func setupDelete() {
        deleteTriggered.asObservable()
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                var expenses = self.expenseSections.value
                let deletedExpense = expenses[indexPath.section].rows.remove(at: indexPath.row)
                self.expenseService.deleteExpense(deletedExpense)
                if expenses[indexPath.section].rows.isEmpty {
                    expenses.remove(at: indexPath.section)
                }
                self.expenseSections.accept(expenses)
            })
            .disposed(by: disposeBag)
    }
}
