//
//  ExpenseServiceSpec.swift
//  ExpenserTests
//
//  Created by Dushyant Singh on 16/1/22.
//


import Nimble
import Quick
import RealmSwift
import RxSwift

@testable import Expenser

class ExpenseServiceSpec: QuickSpec {
    override func spec() {
        describe("ExpenseService Test") {
            var subject: ExpenseService!
            beforeEach {
                let mockDB = MockExpenseDB()
                mockDB.expenses = ExpenseFactory.getExpenses_2()
                subject = ExpenseService(expenseDB: mockDB)
            }
            context("fetch all expenses") {
                it("should have 3 sections") {
                    expect(subject.getAllExpenses().count) == 3
                }
                context("January Expenses") {
                    var janExpense: ExpenseSectionModel!
                    beforeEach {
                        janExpense = subject.getAllExpenses()[0]
                    }
                    it("should have 3 expenses") {
                        expect(janExpense.rows.count) == 3
                    }
                    it("should have header title") {
                        expect(janExpense.header) == "January 2022"
                    }
                    it("should have first row") {
                        let rowExpense = janExpense.rows[0]
                        expect(rowExpense.expenseDate) == "12/01/2022".toDate()
                        expect(rowExpense.amount) == 632.8
                        expect(rowExpense.title) == "Car repair"
                    }
                    it("should have second row") {
                        let rowExpense = janExpense.rows[1]
                        expect(rowExpense.expenseDate) == "10/01/2022".toDate()
                        expect(rowExpense.amount) == 42.9
                        expect(rowExpense.title) == "Movie night"
                    }
                    it("should have third row") {
                        let rowExpense = janExpense.rows[2]
                        expect(rowExpense.expenseDate) == "07/01/2022".toDate()
                        expect(rowExpense.amount) == 23.12
                        expect(rowExpense.title) == "Dinner outisde"
                    }
                }

                context("December Expenses") {
                    var decExpense: ExpenseSectionModel!
                    beforeEach {
                        decExpense = subject.getAllExpenses()[1]
                    }
                    it("should have 1 expense") {
                        expect(decExpense.rows.count) == 1
                    }
                    it("should have header title") {
                        expect(decExpense.header) == "December 2021"
                    }
                    it("should have first row") {
                        let rowExpense = decExpense.rows[0]
                        expect(rowExpense.expenseDate) == "18/12/2021".toDate()
                        expect(rowExpense.amount) == 200.0
                        expect(rowExpense.title) == "Donation"
                    }
                }

                context("November Expenses") {
                    var novExpense: ExpenseSectionModel!
                    beforeEach {
                        novExpense = subject.getAllExpenses()[2]
                    }
                    it("should have 1 expense") {
                        expect(novExpense.rows.count) == 1
                    }
                    it("should have header title") {
                        expect(novExpense.header) == "November 2021"
                    }
                    it("should have first row") {
                        let rowExpense = novExpense.rows[0]
                        expect(rowExpense.expenseDate) == "21/11/2021".toDate()
                        expect(rowExpense.amount) == 1029.2
                        expect(rowExpense.title) == "Travel"
                    }
                }
            }
        }
    }
}

class MockExpenseDB: RealmDbType {
    var dbName: String = "mock"

    var realm: Realm?

    var schemaVersion: UInt64 = 1

    var objectTypes: [Object.Type] = []

    var changesObserved: PublishSubject<Void>?

    var expenses: [ExpenseObject]?
    func realmObjects<T: Object>(type: T.Type) -> [T]? {
        return expenses as? [T]
    }
}
