//
//  AddExpenseViewModel.swift
//  Expenser
//
//  Created by Dushyant Singh on 11/1/22.
//

import Foundation
import RxCocoa
import RxSwift

class AddExpenseViewModel {
    enum Event {
        case dismiss
        case invalidFields
    }
    let expenseService: ExpenseServiceType

    var expenseTitle = BehaviorRelay(value: "")
    var expenseAmount = BehaviorRelay(value: "")
    var expenseDate = BehaviorRelay(value: Date())

    var events = PublishSubject<Event>()
    private let disposeBag = DisposeBag()
    let addExpenseTapped = PublishSubject<Void>()

    init(service: ExpenseServiceType) {
        expenseService = service
        setupAddExpense()
    }
}

private extension AddExpenseViewModel {
    func setupAddExpense() {
        addExpenseTapped
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.saveExpense()
            })
            .disposed(by: disposeBag)
    }

    func saveExpense() {
        guard let amount = Double(self.expenseAmount.value),
              !expenseTitle.value.isEmpty
        else {
            events.onNext(.invalidFields)
            return
        }
        expenseService.addExpense(title: expenseTitle.value,
                                  date: expenseDate.value,
                                  amount: amount)
        self.events.onNext(.dismiss)
    }
}
