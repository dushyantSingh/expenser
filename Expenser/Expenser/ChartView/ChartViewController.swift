//
//  ChartViewController.swift
//  Expenser
//
//  Created by Dushyant Singh on 16/1/22.
//

import UIKit
import Charts
import RxSwift

class ChartViewController: UIViewController {
    @IBOutlet weak var barChartView: BarChartView!

    var viewModel: ChartViewModel!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCharts()
    }

    func setupCharts() {
        viewModel.expenseDataSet.asObservable()
            .map { dataSet in
                var dataEntries: [BarChartDataEntry] = []
                for i in 0..<dataSet.count {
                    let dataEntry = BarChartDataEntry(x: Double(i),
                                                      y: dataSet[i].yValue)
                    dataEntries.append(dataEntry)
                }
                let chartDataSet = BarChartDataSet(entries: dataEntries,
                                                   label: "Bar Chart View")
                return BarChartData(dataSet: chartDataSet)
            }
            .bind(to: barChartView.rx.data)
            .disposed(by: disposeBag)

        viewModel.expenseDataSet.asObservable()
            .map { dataSet in
                var xValueTitles = [String]()
                for value in dataSet {
                    xValueTitles.append(value.xValueTitle())
                }
                return IndexAxisValueFormatter(values: xValueTitles)
            }
            .bind(to: barChartView.xAxis.rx.valueFormatter)
            .disposed(by: disposeBag)
    }
}
