//
//  SustainableViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/21/24.
//

import UIKit
import DGCharts
class SustainableViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var chartView: BarChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChart()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .clear
    }
    
    private func setupChart(){
        let dataEntries = [
            BarChartDataEntry(x: 1.0, y: 10.0, data: "Label 0"),
                BarChartDataEntry(x: 2.0, y: 20.0, data: "Label 1"),
                BarChartDataEntry(x: 3.0, y: 30.0, data: "Label 2"),
                BarChartDataEntry(x: 4.0, y: 40.0, data: "Label 3"),
                BarChartDataEntry(x: 5.0, y: 50.0, data: "Label 4"),
                BarChartDataEntry(x: 6.0, y: 60.0, data: "Label 5")
            ]

            let chartDataSet = BarChartDataSet(entries: dataEntries)
            let chartData = BarChartData(dataSet: chartDataSet)
            chartView.data = chartData
    }
}
