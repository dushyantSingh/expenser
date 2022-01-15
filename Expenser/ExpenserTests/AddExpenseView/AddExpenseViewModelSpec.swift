//
//  AddExpenseViewModelSpec.swift
//  ExpenserTests
//
//  Created by Dushyant Singh on 15/1/22.
//

import Nimble
import Quick

@testable import Expenser

class AddExpenseViewModelSpec: QuickSpec {
    override func spec() {
        describe("AddExpenseViewModel test") {
            var subject: AddExpenseViewModel!
            var mockService: MockExpenseService!

            beforeEach {
                mockService = MockExpenseService()
                subject = AddExpenseViewModel(service: mockService)
            }
            context("when add expense is tapped") {
                it("should call addExpense in expense service") {
                    subject.expenseTitle.accept("First Expense")
                    subject.expenseDate.accept("12/01/2022".toDate())
                    subject.expenseAmount.accept("120")
                    subject.addExpenseTapped.onNext(())
                    expect(mockService.addExpenseCalledWithTitle) == "First Expense"
                    expect(mockService.addExpenseCalledWithDate) == "12/01/2022".toDate()
                    expect(mockService.addExpenseCalledWithAmount) == 120
                }
                it("should call addExpense in expense service") {
                    subject.expenseTitle.accept("Second Expense")
                    subject.expenseDate.accept("21/10/2021".toDate())
                    subject.expenseAmount.accept("10")
                    subject.addExpenseTapped.onNext(())
                    expect(mockService.addExpenseCalledWithTitle) == "Second Expense"
                    expect(mockService.addExpenseCalledWithDate) == "21/10/2021".toDate()
                    expect(mockService.addExpenseCalledWithAmount) == 10
                }
            }
        }
    }
}

class MockExpenseService: ExpenseServiceType {
    func getAllExpenses() -> [ExpenseObject] {
        return []
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

extension String {
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/mm/YYYY"
        return formatter.date(from: self)!
    }
}
