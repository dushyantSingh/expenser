//
//  ViewController.swift
//  Expenser
//
//  Created by Dushyant Singh on 11/1/22.
//

import UIKit

class AllExpenseViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
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
        return 1
    }
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "\(ExpenseTableViewCell.self)"
        guard let cell = tableView
                .dequeueReusableCell(withIdentifier: identifier,
                                     for: indexPath) as? ExpenseTableViewCell
        else { return UITableViewCell() }
        return cell
    }
}

