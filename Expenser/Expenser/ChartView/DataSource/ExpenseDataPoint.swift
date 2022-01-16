//
//  ExpenseDataPoint.swift
//  Expenser
//
//  Created by Dushyant Singh on 16/1/22.
//

import Foundation
protocol ChartDataPoint {
    associatedtype XElement
    var yValue: Double { get set }
    var xValue: XElement { get set }
    func xValueTitle() -> String
}
struct ExpenseDataPoint: ChartDataPoint {
    var yValue: Double
    var xValue: Date

    func xValueTitle() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        return formatter.string(from: xValue)
    }
}
