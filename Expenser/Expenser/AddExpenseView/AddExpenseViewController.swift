//
//  AddExpenseViewController.swift
//  Expenser
//
//  Created by Dushyant Singh on 11/1/22.
//

import Foundation
import UIKit

class AddExpenseViewController: UIViewController {
    @IBOutlet weak var expenseTitle: CustomTextField!
    @IBOutlet weak var expenseAmount: CustomTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Add a new expense"

        expenseTitle.titleFontSize = .large
        expenseAmount.titleFontSize = .large
        expenseTitle.title = "Expense Title"
        expenseAmount.title = "Amount ($)"
        expenseAmount.keyboardType = .decimalPad
    }
}
