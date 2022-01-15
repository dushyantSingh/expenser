//
//  AddExpenseViewController.swift
//  Expenser
//
//  Created by Dushyant Singh on 11/1/22.
//

import RxSwift
import RxCocoa
import UIKit

class AddExpenseViewController: UIViewController {
    @IBOutlet weak var expenseTitle: CustomTextField!
    @IBOutlet weak var expenseAmount: CustomTextField!
    @IBOutlet weak var addExpenseButton: UIButton!
    @IBOutlet weak var expenseDatePickerView: UIDatePicker!

    var viewModel: AddExpenseViewModel!

    private var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        setupObservations()
        setupEvents()
    }

    func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Add a new expense"
    }

    func setupUI() {
        expenseTitle.titleFontSize = .large
        expenseAmount.titleFontSize = .large
        expenseTitle.title = "Expense Title"
        expenseAmount.title = "Amount ($)"
        expenseAmount.keyboardType = .decimalPad
    }

    func setupObservations() {
        expenseAmount.rx.text.orEmpty
            .bind(to: viewModel.expenseAmount)
            .disposed(by: disposeBag)

        expenseTitle.rx.text.orEmpty
            .bind(to: viewModel.expenseTitle)
            .disposed(by: disposeBag)

        expenseDatePickerView.rx.value
            .asObservable()
            .bind(to: viewModel.expenseDate)
            .disposed(by: disposeBag)

        addExpenseButton.rx.tap
            .bind(to: viewModel.addExpenseTapped)
            .disposed(by: disposeBag)
    }

    func setupEvents() {
        viewModel.events
            .asObservable()
            .subscribe(onNext: { [weak self] event in
                switch event {
                case .dismiss:
                    self?.dismiss(animated: true)
                case .invalidFields:
                    self?.showAlertForInvalidFields()
                }
            })
            .disposed(by: disposeBag)
    }

    func showAlertForInvalidFields() {
        let alert = UIAlertController(title: "Invalid Entry",
                                      message: "Please fill all the fields",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
