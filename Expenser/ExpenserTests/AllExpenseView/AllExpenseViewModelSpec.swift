//
//  AllExpenseViewModelSpec.swift
//  ExpenserTests
//
//  Created by Dushyant Singh on 15/1/22.
//

import Nimble
import Quick

@testable import Expenser

class AllExpenseViewModelSpec: QuickSpec {
    override func spec() {
        describe("AllExpenseViewModel Test") {
            var subject: AllExpenseViewModel!
            var mockService: MockExpenseService!
            beforeEach {
                mockService = MockExpenseService()
                mockService.stubExpenses = ExpenseFactory.getExpenses_1()
                subject = AllExpenseViewModel(service: mockService)
            }
            context("fetch all expenses") {
                it("should return 1 section") {
                    expect(subject.expenseSections.count) == 1
                }
                it("should return 4 expenses") {
                    expect(subject.expenseSections.first?.rows.count) == 4
                }
                it("should have header as January 2022") {
                    expect(subject.expenseSections.first!.header) == "January 2022"
                }
                it("should return expenses in recent expense order") {
                    let firstExpenseDate = subject.expenseSections[0].rows[0].expenseDate
                    let secondExpenseDate = subject.expenseSections[0].rows[1].expenseDate
                    let thirdExpenseDate = subject.expenseSections[0].rows[2].expenseDate
                    let fourthExpenseDate = subject.expenseSections[0].rows[3].expenseDate
                    expect(firstExpenseDate > secondExpenseDate) == true
                    expect(secondExpenseDate > thirdExpenseDate) == true
                    expect(thirdExpenseDate > fourthExpenseDate) == true
                }
            }
        }
    }
}
