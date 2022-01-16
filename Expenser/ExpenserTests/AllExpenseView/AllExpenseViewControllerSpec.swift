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
            var viewModel: AllExpenseViewModel!

            context("when there is no expense") {
                beforeEach {
                    let mockService = MockExpenseService()
                    mockService.stubExpenses = [ExpenseSectionModel]()
                    viewModel = AllExpenseViewModel(service: mockService )
                    subject = UIViewController.make(viewController: AllExpenseViewController.self)
                    subject.viewModel = viewModel
                    _ = subject.view
                }
                it("should not show table view") {
                    expect(subject.tableView.isHidden) == true
                }
                it("should show label with text to add new expense") {
                    expect(subject.addExpenseLabel.isHidden) == false
                    expect(subject.addExpenseLabel.text) == "Add a new expense"
                }
            }
            context("when there is stored expenses") {
                beforeEach {
                    let mockService = MockExpenseService()
                    mockService.stubExpenses = ExpenseFactory.getExpenseSectionModel_2()
                    viewModel = AllExpenseViewModel(service: mockService )
                    subject = UIViewController.make(viewController: AllExpenseViewController.self)
                    subject.viewModel = viewModel
                    _ = subject.view
                }
                context("when view loads") {
                    it("should display title") {
                        expect(subject.navigationItem.title) == "Expenses"
                    }
                    it("should show table view") {
                        expect(subject.tableView.isHidden) == false
                    }
                    it("should not show label with text to add new expense") {
                        expect(subject.addExpenseLabel.isHidden) == true
                    }
                    it("should display expenses for 3 months") {
                        expect(subject.tableView.numberOfSections) == 3
                    }
                    context("January Expenses") {
                        it("should have 3 expenses") {
                            expect(subject.tableView.numberOfRows(inSection: 0)) == 3
                        }
                        it("should have header title") {
                            expect(subject.tableView.dataSource?.tableView?(subject.tableView,
                                                                            titleForHeaderInSection: 0)) == "January 2022"
                        }
                        it("should have first row") {
                            let indexPath = IndexPath(row: 0, section: 0)
                            let cell = subject.tableView.cellForRow(at: indexPath) as! ExpenseTableViewCell
                            expect(cell.dateTextLabel.text) == "12 Jan"
                            expect(cell.amountTextLabel.text) == "$632.8"
                            expect(cell.primaryTextLabel.text) == "Car repair"
                        }
                        it("should have second row") {
                            let indexPath = IndexPath(row: 1, section: 0)
                            let cell = subject.tableView.cellForRow(at: indexPath) as! ExpenseTableViewCell
                            expect(cell.dateTextLabel.text) == "10 Jan"
                            expect(cell.amountTextLabel.text) == "$42.9"
                            expect(cell.primaryTextLabel.text) == "Movie night"
                        }
                        it("should have third row") {
                            let indexPath = IndexPath(row: 2, section: 0)
                            let cell = subject.tableView.cellForRow(at: indexPath) as! ExpenseTableViewCell
                            expect(cell.dateTextLabel.text) == "07 Jan"
                            expect(cell.amountTextLabel.text) == "$23.12"
                            expect(cell.primaryTextLabel.text) == "Dinner outisde"
                        }
                    }

                    context("December Expenses") {
                        it("should have 1 expense") {
                            expect(subject.tableView.numberOfRows(inSection: 1)) == 2
                        }
                        it("should have header title") {
                            expect(subject.tableView.dataSource?.tableView?(subject.tableView,
                                                                            titleForHeaderInSection: 1)) == "December 2021"
                        }
                        it("should have first row") {
                            let indexPath = IndexPath(row: 0, section: 1)
                            let cell = subject.tableView.cellForRow(at: indexPath) as! ExpenseTableViewCell
                            expect(cell.dateTextLabel.text) == "21 Dec"
                            expect(cell.amountTextLabel.text) == "$99.2"
                            expect(cell.primaryTextLabel.text) == "Travel 2"
                        }
                        it("should have second row") {
                            let indexPath = IndexPath(row: 1, section: 1)
                            let cell = subject.tableView.cellForRow(at: indexPath) as! ExpenseTableViewCell
                            expect(cell.dateTextLabel.text) == "18 Dec"
                            expect(cell.amountTextLabel.text) == "$200.0"
                            expect(cell.primaryTextLabel.text) == "Donation"
                        }
                    }

                    context("November Expenses") {
                        it("should have 1 expense") {
                            expect(subject.tableView.numberOfRows(inSection: 2)) == 1
                        }
                        it("should have header title") {
                            expect(subject.tableView.dataSource?.tableView?(subject.tableView,
                                                                            titleForHeaderInSection: 2)) == "November 2021"
                        }
                        it("should have first row") {
                            let indexPath = IndexPath(row: 0, section: 2)
                            let cell = subject.tableView.cellForRow(at: indexPath) as! ExpenseTableViewCell
                            expect(cell.dateTextLabel.text) == "21 Nov"
                            expect(cell.amountTextLabel.text) == "$1029.2"
                            expect(cell.primaryTextLabel.text) == "Travel"
                        }
                    }
                }
            }
        }
    }
}
