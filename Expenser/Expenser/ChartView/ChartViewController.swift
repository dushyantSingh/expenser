//
//  ChartViewController.swift
//  Expenser
//
//  Created by Dushyant Singh on 16/1/22.
//

import UIKit
import Charts
import RxSwift
import RxCocoa

class ChartViewController: UIViewController {
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!

    var viewModel: ChartViewModel!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCharts()
        setupButtons()
        setupNavigationBar()

        viewModel.testEscapingClouse {
            print("Closure completed")
            print(self.previousButton ?? "")
        }
    }
    deinit {
        print("\(Self.self) deinit")
    }

    func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.monthTitle.asObservable()
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
    }

    func setupButtons() {
        nextButton.rx.tap
            .bind(to: viewModel.nextButtonTapped)
            .disposed(by: disposeBag)
        previousButton.rx.tap
            .bind(to: viewModel.previousButtonTapped)
            .disposed(by: disposeBag)
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
