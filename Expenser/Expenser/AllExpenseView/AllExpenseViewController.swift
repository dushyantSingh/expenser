//
//  ViewController.swift
//  Expenser
//
//  Created by Dushyant Singh on 11/1/22.
//

import UIKit
import RxSwift

class AllExpenseViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var viewModel: AllExpenseViewModel!

    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
    }
}

private extension AllExpenseViewController {
    func setupNavigationBar() {
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add,
                                           target: self,
                                           action: #selector(addExpense(sender:)))
        navigationItem.rightBarButtonItem = addBarButton
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Expenses"
    }

    @objc
    func addExpense(sender: UIBarButtonItem) {
        let addExpenseController = UIViewController.make(viewController: AddExpenseViewController.self)
        addExpenseController.viewModel = AddExpenseViewModel(service: ExpenseService(expenseDB: ExpenseDB.shared))
        self.present(UINavigationController(rootViewController: addExpenseController),
                     animated: true)
    }
}

extension AllExpenseViewController: UITableViewDataSource {
    func setupTableView() {
        let identifier = "\(ExpenseTableViewCell.self)"
        tableView.register(UINib(nibName: identifier,
                                bundle: Bundle(for: ExpenseTableViewCell.self)),
                          forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        viewModel.expenseService.changesObserved.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.expenseSections.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.expenseSections[section].rows.count
    }

    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return viewModel.expenseSections[section].header
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "\(ExpenseTableViewCell.self)"
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: identifier,
                                     for: indexPath) as? ExpenseTableViewCell
        else { return UITableViewCell() }
        let expense = viewModel.expenseSections[indexPath.section].rows[indexPath.row]
        configure(cell: cell, expense: expense)
        return cell
    }

    func configure(cell: ExpenseTableViewCell, expense: ExpenseObject) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        let expenseDate = dateFormatter.string(from: expense.expenseDate)
        let amount = "\(expense.currencySymbol)\(expense.amount)"
        cell.configure(dateText: expenseDate,
                       primaryText: expense.title,
                       spentAmount: amount)
    }
}

extension AllExpenseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            viewModel.deleteTriggered.onNext(indexPath)
            tableView.endUpdates()
        }
    }
}
