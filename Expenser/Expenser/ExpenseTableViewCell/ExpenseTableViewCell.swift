//
//  ExpenseTableViewCell.swift
//  Expenser
//
//  Created by Dushyant Singh on 11/1/22.
//

import Foundation
import UIKit

class ExpenseTableViewCell: UITableViewCell {
    @IBOutlet weak var stackBackgroundView: UIView!

    @IBOutlet weak var dateTextLabel: UILabel!
    @IBOutlet weak var primaryTextLabel: UILabel!
    @IBOutlet weak var amountTextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func configure(dateText: String, primaryText: String, spentAmount: String) {
        dateTextLabel.text = dateText
        primaryTextLabel.text = primaryText
        amountTextLabel.text = spentAmount
    }
}

private extension ExpenseTableViewCell {
    func setupUI() {
        stackBackgroundView.layer.cornerRadius = 5.0
        stackBackgroundView.layer.shadowColor = UIColor.black.cgColor
        stackBackgroundView.layer.shadowOpacity = 0.2
        stackBackgroundView.layer.shadowRadius = 3
        stackBackgroundView.layer.shadowOffset = .zero
        stackBackgroundView.layer.shouldRasterize = true
        stackBackgroundView.layer.rasterizationScale = UIScreen.main.scale

        dateTextLabel.font = Theme.Font.thinFont(with: 18)
        primaryTextLabel.font = Theme.Font.regularFont(with: 18)
        amountTextLabel.font = Theme.Font.regularFont(with: 18)
        amountTextLabel.textColor = Theme.Color.brickRedColor
    }
}
