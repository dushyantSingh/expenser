//
//  ExpenseFactory.swift
//  ExpenserTests
//
//  Created by Dushyant Singh on 15/1/22.
//

import Foundation

@testable import Expenser

struct ExpenseFactory {
    static func getExpenses_1() -> [ExpenseObject] {
        let expense4Jan = ExpenseObject()
        expense4Jan.expenseDate = "04/01/2022".toDate()
        expense4Jan.title = "Some food"
        expense4Jan.amount = 19.20

        let expense7Jan = ExpenseObject()
        expense7Jan.expenseDate = "07/01/2022".toDate()
        expense7Jan.title = "Dinner outisde"
        expense7Jan.amount = 13.12

        let expense10Jan = ExpenseObject()
        expense10Jan.expenseDate = "10/01/2022".toDate()
        expense10Jan.title = "Movie night"
        expense10Jan.amount = 22.90

        let expense12Jan = ExpenseObject()
        expense12Jan.expenseDate = "12/01/2022".toDate()
        expense12Jan.title = "Car repair"
        expense12Jan.amount = 632.80

        return [expense4Jan, expense7Jan, expense10Jan, expense12Jan]
    }

    static func getExpenses_2() -> [ExpenseObject] {
        let expense18Dec = ExpenseObject()
        expense18Dec.expenseDate = "18/12/2021".toDate()
        expense18Dec.title = "Donation"
        expense18Dec.amount = 200.00

        let expense21Nov = ExpenseObject()
        expense21Nov.expenseDate = "21/11/2021".toDate()
        expense21Nov.title = "Travel"
        expense21Nov.amount = 1029.20

        let expense7Jan = ExpenseObject()
        expense7Jan.expenseDate = "07/01/2022".toDate()
        expense7Jan.title = "Dinner outisde"
        expense7Jan.amount = 23.12

        let expense10Jan = ExpenseObject()
        expense10Jan.expenseDate = "10/01/2022".toDate()
        expense10Jan.title = "Movie night"
        expense10Jan.amount = 42.90

        let expense12Jan = ExpenseObject()
        expense12Jan.expenseDate = "12/01/2022".toDate()
        expense12Jan.title = "Car repair"
        expense12Jan.amount = 632.80

        return [expense18Dec, expense21Nov, expense7Jan, expense10Jan, expense12Jan]
    }
}
