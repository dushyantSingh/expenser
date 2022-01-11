//
//  ExpenseTableViewCellSpec.swift
//  ExpenseTableViewCellSpec
//
//  Created by Dushyant Singh on 11/1/22.
//

import Nimble
import Quick

@testable import Expenser

class ExpenseTableViewCellSpec: QuickSpec {
    override func spec() {
        describe("ExpenseTableViewCell test") {
            var subject: ExpenseTableViewCell!

            beforeEach {
                let nibName = "\(ExpenseTableViewCell.self)"
                let nib = UINib(nibName: nibName,
                                bundle: Bundle(for: ExpenseTableViewCell.self))
                let nibViews = nib.instantiate(withOwner: nil, options: nil)
                guard let cell = nibViews.first as? ExpenseTableViewCell else {
                    fatalError("Unable to create view from nib \(nibName)")
                }
                subject = cell
            }

            context("when cell loads") {
                context("First Value") {
                    beforeEach {
                        subject.configure(dateText: "12 Jan",
                                          primaryText: "Went to supermarket",
                                          spentAmount: "$100")
                    }
                    it("should display date") {
                        expect(subject.dateTextLabel.text) == "12 Jan"
                    }
                    it("should display title") {
                        expect(subject.primaryTextLabel.text) == "Went to supermarket"
                    }
                    it("should display amount") {
                        expect(subject.amountTextLabel.text) == "$100"
                    }
                }
                context("Second Value") {
                    beforeEach {
                        subject.configure(dateText: "12 Aug",
                                          primaryText: "Went for Staycation",
                                          spentAmount: "$1000")
                    }
                    it("should display date") {
                        expect(subject.dateTextLabel.text) == "12 Aug"
                    }
                    it("should display title") {
                        expect(subject.primaryTextLabel.text) == "Went for Staycation"
                    }
                    it("should display amount") {
                        expect(subject.amountTextLabel.text) == "$1000"
                    }
                }
                context("Third Value") {
                    beforeEach {
                        subject.configure(dateText: "31 Dec",
                                          primaryText: "Went for Dinner",
                                          spentAmount: "$200")
                    }
                    it("should display date") {
                        expect(subject.dateTextLabel.text) == "31 Dec"
                    }
                    it("should display title") {
                        expect(subject.primaryTextLabel.text) == "Went for Dinner"
                    }
                    it("should display amount") {
                        expect(subject.amountTextLabel.text) == "$200"
                    }
                }
            }
        }
    }
}
