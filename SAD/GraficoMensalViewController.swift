//
//  GraficoMensalViewController.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 06/12/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class GraficoMensalViewController: UIViewController {

    
    
    @IBOutlet weak var barChart: BarChartView!
    var mes:Int!
    var glicemias = [Glicemia]()
    var qtdDias = 0
    var grafico = [Int:Double]() //Dia e Valor
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //barChart.noDataText = "Não contem dados glicemicos"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(mes ?? 0)
        
        getGlicemias()
        qtdDias = getDiasDoMes()
        preparadaGrafico()
        initChart()
        
        
    }
    
    func getGlicemias(){
        let usuario = Usuario()
        _ = usuario.hasUsuarioLogado(realm: try! Realm())
        
        glicemias = usuario.glicemias.filter{
            let calendar = NSCalendar.current
            let mes = calendar.component(Calendar.Component.month, from: $0.dtCadastro as Date)
            return mes == self.mes
        }
    }
    
    func getDiasDoMes() -> Int{
        
        if mes == 1
                || mes == 3
                || mes == 5
                || mes == 7
                || mes == 8
                || mes == 10
            || mes == 12 {
            
            return 31
        
        } else if mes == 4
                    || mes == 6
                    || mes == 9
                    || mes == 11{
            
            return 30
            
        } else {
            return 28
        }
        
    }
    
    func preparadaGrafico(){
    
        _ = glicemias.map{
            let calendar = Calendar.current
            let dia = calendar.component(Calendar.Component.day, from: $0.dtCadastro as Date)
            self.grafico[dia] = $0.valorGlicemico + (self.grafico[dia] ?? 0)
        }
        
        print(grafico)
        
        
    }
    
    func initChart(){
        // Initialize an array to store chart data entries (values; y axis)
        var salesEntries = [ChartDataEntry]()
        
        // Initialize an array to store months (labels; x axis)
        var salesMonths = [Int]()
        
        for num in 1...qtdDias {
            
            if (self.grafico.count <= num){
                
                let valor = self.grafico[num] ?? 0
                
                let saleEntry = BarChartDataEntry(x: Double(num), y: valor)
                salesEntries.append(saleEntry)
                
            } else {
                let saleEntry = BarChartDataEntry(x: Double(num), y: 0)
                salesEntries.append(saleEntry)
            }
            salesMonths.append(num)
            
        }
        
        
        // Create bar chart data set containing salesEntries
        let chartDataSet = BarChartDataSet(values: salesEntries, label: "Glicemia")
        
        // Create bar chart data with data set and array with values for x axis
        let chartData = BarChartData(dataSets: [chartDataSet])
        
        // Set bar chart data to previously created data
        barChart.data = chartData
        barChart.xAxis.labelPosition = .bottom
        
    }


}
