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
        tableView.reloadData()
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
