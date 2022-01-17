//
//  ChartViewModel.swift
//  Expenser
//
//  Created by Dushyant Singh on 16/1/22.
//

import Foundation
import RxSwift
import RxCocoa

class ChartViewModel {
    let expenseService: ExpenseServiceType
    var expenseDataSet = BehaviorRelay(value: [ExpenseDataPoint]())

    let nextButtonTapped = PublishSubject<Void>()
    let previousButtonTapped = PublishSubject<Void>()
    let expenses: [ExpenseSectionModel]

    var monthTitle = BehaviorRelay(value: "")
    var monthIndex = 0

    private let disposeBag = DisposeBag()
    init(service: ExpenseServiceType) {
        expenseService = service
        expenses = expenseService.getAllExpenses()
        fetchExpenseDataSet()
        setupNextAndPreviousButton()
    }
}

private extension ChartViewModel {
    func setupNextAndPreviousButton() {
        nextButtonTapped.asObservable()
            .subscribe(onNext: { [weak self]_ in
                guard let self = self else { return }
                if self.monthIndex > 0{
                    self.monthIndex -= 1
                    self.fetchExpenseDataSet()
                }
            })
            .disposed(by: disposeBag)

        previousButtonTapped.asObservable()
            .subscribe(onNext: { _ in
                if self.monthIndex < self.expenses.count - 1{
                    self.monthIndex += 1
                    self.fetchExpenseDataSet()
                }
            })
            .disposed(by: disposeBag)
    }
    func fetchExpenseDataSet() {
        var dataSet = [ExpenseDataPoint]()
        if monthIndex < expenses.count {
            let currentExpenses = expenses[monthIndex]
            monthTitle.accept(currentExpenses.header)
            currentExpenses.rows.forEach { item in
                dataSet.append(ExpenseDataPoint(yValue: item.amount,
                                                xValue: item.expenseDate))
            }
            expenseDataSet.accept(dataSet)
        } else {
            monthTitle.accept("No expense available")
        }
    }
}
