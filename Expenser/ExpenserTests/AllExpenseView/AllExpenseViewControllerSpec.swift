//
//  AllExpenseViewControllerSpec.swift
//  ExpenserTests
//
//  Created by Dushyant Singh on 11/1/22.
//

import Nimble
import Quick

@testable import Expenser

class AllExpenseViewControllerSpec: QuickSpec {
    override func spec() {
        describe("AllExpenseViewController test") {
            var subject: AllExpenseViewController!

            beforeEach {
                subject = UIViewController.make(viewController: AllExpenseViewController.self)
                _ = subject.view
            }

            context("when cell loads") {
                it("should display title") {
                    expect(subject.navigationItem.title) == "Expenses"
                }

                it("should display 12 dummy expenses") {
                    expect(subject.tableView.numberOfRows(inSection: 0)) == 14
                }
                it("should have dummy data") {
                    let cell = subject.tableView.cellForRow(at: IndexPath(row: 0,
                                                                          section: 0)) as! ExpenseTableViewCell
                    expect(cell.dateTextLabel.text) == "12 Dec"
                    expect(cell.amountTextLabel.text) == "$23.18"
                    expect(cell.primaryTextLabel.text) == "Something important "
                }
            }
        }
    }
}
