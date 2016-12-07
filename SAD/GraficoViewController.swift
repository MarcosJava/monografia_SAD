//
//  GraficoViewController.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 04/12/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import UIKit
import Charts
import RealmSwift


class GraficoViewController: UIViewController {

    @IBOutlet weak var barChartView: BarChartView!
    
    
    var graficos:[Int:Double]!
    var months:[String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var glicemias = [Glicemia]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popGlicemia()
        
        if glicemias.count > 0 {
            popSales()
            initChart()
        } else {
            barChartView.noDataText = "Não contem dados glicemicos"
        }
    }
    
    func popSales(){
        
        
        graficos = [1:0.0, 2:0.0, 3:0.0, 4:0.0, 5:0.0, 6:0.0, 7:0.0, 8:0.0, 9:0.0, 10:0.0, 11:0.0, 12:0.0]
        for glicemia in glicemias {
            
            let date = glicemia.dtCadastro
            let calendar = NSCalendar.current
            let mes = calendar.component(Calendar.Component.month, from: date as Date)
            
            var valorDoMes = graficos[mes]
            valorDoMes = glicemia.valorGlicemico + (valorDoMes ?? 0)
            
            graficos[mes] = valorDoMes
            
        }
        
        
    }
    
    func popGlicemia(){
        
        let usuario = Usuario()
        _ = usuario.hasUsuarioLogado(realm: try! Realm())
        
        if usuario.glicemias.count > 0 {
            glicemias = usuario.glicemias.filter{$0.valorGlicemico > 0.0}
        }
        
    }
    
    func initChart(){
        // Initialize an array to store chart data entries (values; y axis)
        var salesEntries = [ChartDataEntry]()
        
        // Initialize an array to store months (labels; x axis)
        var salesMonths = [String]()
        
        
        for (mes, valor) in graficos {
            // Create single chart data entry and append it to the array
            let saleEntry = BarChartDataEntry(x: Double(mes), y: valor)
            salesEntries.append(saleEntry)
            
            // Append the month to the array
            salesMonths.append(months[mes - 1])
        }
        
        // Create bar chart data set containing salesEntries
        let chartDataSet = BarChartDataSet(values: salesEntries, label: "Glicemia")
        
        // Create bar chart data with data set and array with values for x axis
        let chartData = BarChartData(dataSets: [chartDataSet])
        
        // Set bar chart data to previously created data
        barChartView.data = chartData
        barChartView.xAxis.labelPosition = .bottom
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
}
