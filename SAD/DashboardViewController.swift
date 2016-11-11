//
//  DashboardViewController.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 21/10/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import Charts

var usuarioDTO:UsuarioDTO?

class VisitorCount {
    var date: Date = Date()
    var count: Int = Int(0)
}

class DashboardViewController: UIViewController {

    @IBOutlet weak var barView: BarChartView!
    @IBOutlet weak var inputDados: UITextField!
    
    
    var valores = Array<VisitorCount>()
    var months: [String]!
    
    
    @IBAction func btnAdd(_ sender: Any) {
        
        if let value = inputDados.text , value != "" {
//            let visitorCount = VisitorCount()
//            visitorCount.count = (NumberFormatter().number(from: value)?.intValue)!
//            valores.append(visitorCount)
//            updateChartWithData()
//            inputDados.text = ""
            months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
            let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
            
            setChart(dataPoints: months, values: unitsSold)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.hideKeyboardWhenTappedAround()
        
        //self.barView.noDataText = "Nao contem dados para o relatorio"
        addNavigatiorButton()
    }
    
    func addNavigatiorButton() -> Void {
        
        let buttonRight = UIBarButtonItem(title: "Sair", style: .done, target: self, action: Selector(("logout")))
        self.navigationItem.rightBarButtonItem = buttonRight;
        self.navigationItem.rightBarButtonItem?.title = "Logout"
        
    }
    
    func logout() {
        
        
        
        if let usuario = usuarioDTO?.parserToEntity(){
            usuario.id = (usuarioDTO?.id)!
            usuario.logado = false;
            usuario.update()
        }
        
        
        goInicial()
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: values[i], y: Double(i))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        let chartData = BarChartData(dataSet: chartDataSet)
        barView.data = chartData
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<valores.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(valores[i].count))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Visitor count")
        let chartData = BarChartData(dataSet: chartDataSet)
        barView.data = chartData
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
