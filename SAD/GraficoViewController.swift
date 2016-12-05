//
//  GraficoViewController.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 04/12/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import UIKit
import Charts

class GraficoViewController: UIViewController {

    @IBOutlet weak var barChartView: BarChartView!
    
    var months: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(dataPoints: months, values: unitsSold)
     
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "Nao tem dados"
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry =  BarChartDataEntry(x: values[i], y: Double(i))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Qtde Glicemia")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        
    }
    

}
