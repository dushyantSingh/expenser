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
    init(service: ExpenseServiceType) {
        expenseService = service
        fetchExpenseDataSet()
    }
}

private extension ChartViewModel {
    func fetchExpenseDataSet() {
        let expenses = expenseService.getAllExpenses()
        var dataSet = [ExpenseDataPoint]()
        expenses.forEach { item in
            dataSet.append(ExpenseDataPoint(yValue: item.amount,
                                            xValue: item.expenseDate))
        }
        expenseDataSet.accept(dataSet)
    }
}
