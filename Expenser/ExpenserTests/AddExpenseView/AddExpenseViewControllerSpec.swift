//
//  AddExpenseViewControllerSpec.swift
//  ExpenserTests
//
//  Created by Dushyant Singh on 15/1/22.
//

import Nimble
import Quick
import RxSwift

@testable import Expenser

class AddExpenseViewControllerSpec: QuickSpec {
    override func spec() {
        describe("AllExpenseViewController test") {
            var subject: AddExpenseViewController!
            var disposeBag: DisposeBag!

            beforeEach {
                let mockService = MockExpenseService()
                let viewModel = AddExpenseViewModel(service: mockService)
                disposeBag = DisposeBag()
                subject = UIViewController.make(viewController: AddExpenseViewController.self)
                subject.viewModel = viewModel
                _ = subject.view
            }
            context("when title is updated") {
                it("should update view model") {
                    subject.expenseTitle.text = "Title"
                    subject.expenseTitle.sendActions(for: .editingDidEnd)
                    expect(subject.viewModel.expenseTitle.value) == "Title"
                }
            }
            context("when amount is updated") {
                it("should update view model") {
                    subject.expenseAmount.text = "122"
                    subject.expenseAmount.sendActions(for: .editingDidEnd)
                    expect(subject.viewModel.expenseAmount.value) == "122"
                }
            }
            context("when amount is updated") {
                it("should update view model") {
                    subject.expenseDatePickerView.date = "01/01/2022".toDate()
                    subject.expenseDatePickerView.sendActions(for: .valueChanged)
                    expect(subject.viewModel.expenseDate.value) == "01/01/2022".toDate()
                }
            }
            context("when add expense button is tapped") {
                it("should update view model") {
                    var buttonTapped = false
                    subject.viewModel
                        .addExpenseTapped.asObservable()
                        .subscribe(onNext: { _ in
                            buttonTapped = true
                        })
                        .disposed(by: disposeBag)
                    subject.addExpenseButton.sendActions(for: .touchUpInside)
                    expect(buttonTapped) == true
                }
            }
        }
    }
}
