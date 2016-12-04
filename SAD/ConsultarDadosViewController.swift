//
//  ConsultarDadosViewController.swift
//  SAD
//
//  Created by Marcos Felipe Souza on 21/10/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

import UIKit
import RealmSwift

class ConsultarDadosViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dtPrimeiraField: UITextField!
    @IBOutlet weak var dtSegundaField: UITextField!
    
    var glicemias = [Glicemia]()
    
    let mensagemUtil = MensagensUtil()
    
    let dateFormatter: DateFormatter = {
        let dtFormatter = DateFormatter()
        dtFormatter.dateFormat = "dd/MM/yyyy"
        return dtFormatter
    }()
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Atualizando")
        refreshControl.addTarget(self, action: #selector(ConsultarDadosViewController.handleRefresh), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    var textoFormato: () -> (UIFont) = {
        UIFont(name: "Avenir Next", size:15)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        dtSegundaField.isEnabled = false
        
        hideKeyboardWhenTappedAround()
        configurarPushRefresh()
        configurarDados()
    }
    
    
    
    func configurarDados() -> Void {
        let usuario = Usuario()
        let realm = try? Realm()
        _ = usuario.hasUsuarioLogado(realm: realm!)
        glicemias = Array(usuario.glicemias)
        glicemias.sort(by: { $0.dtCadastro.compare($1.dtCadastro as Date) == .orderedDescending })

    }
    
    @IBAction func buscarEntreDatas(_ sender: Any) {
        
        guard let dtPrimeira = dtPrimeiraField.text, let dtSegunda = dtSegundaField.text else {
            mensagemUtil.alertaSucesso(titulo: "Erro :/", mensagem: "Selecionar as datas", view: self)
            return;
        }
        
        if dtPrimeira != "" && dtSegunda != "" {
            let dtOne = dateFormatter.date(from: dtPrimeira)!
            let dtTwo = dateFormatter.date(from: dtSegunda)!
            
            glicemias = glicemias.filter({
                ($0.dtCadastro.compare(dtOne) == .orderedDescending) && ($0.dtCadastro.compare(dtTwo) == .orderedAscending)
            })
            tableView.reloadData()
        }
    }
    
    @IBAction func dtPrimeiraPicker(_ sender: Any) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        dtPrimeiraField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(ConsultarDadosViewController.dtPrimeiraValueChange), for: .valueChanged)
    }
    
    func dtPrimeiraValueChange(sender: UIDatePicker){
        dtPrimeiraField.text = dateFormatter.string(from: sender.date)
        dtSegundaField.isEnabled = true
    }
    
    
    @IBAction func dtSegundaPicker(_ sender: Any) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        dtSegundaField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(ConsultarDadosViewController.dtSegundaValueChange), for: .valueChanged)
    }
    
    func dtSegundaValueChange(sender: UIDatePicker){
        
        let datePrimeira = dateFormatter.date(from: dtPrimeiraField.text!)
        
        if datePrimeira?.compare(sender.date) == .orderedAscending {
            dtSegundaField.text = dateFormatter.string(from: sender.date)
        
        } else {
            dtSegundaField.text = dateFormatter.string(from: sender.date)
            dtPrimeiraField.text = dateFormatter.string(from: sender.date)
        }
    }
    
    var maiorQue: (Double, Double) -> Bool = {
        if $0 > $1 {
            return true
        } else {
            return false
        }
    }
    
    func glicemiaEhMaior(glicemia: Glicemia) -> Bool{
        let configuracao = Configuracao()
        configuracao.id = glicemia.configuracao
        configuracao.configuracaoComId(realm: try! Realm())
        
        return maiorQue(glicemia.valorGlicemico, configuracao.maiorGlicemia)

    }
    
    func glicemiaEhMenor(glicemia: Glicemia) -> Bool{
        let configuracao = Configuracao()
        configuracao.id = glicemia.configuracao
        configuracao.configuracaoComId(realm: try! Realm())
        
        return !maiorQue(glicemia.valorGlicemico, configuracao.menorGlicemia)
    }
    
    func goDetalheGlicemia(detalhe: DeatalheGlicemia){
        let vcDetalhes = DetalheExameViewController(detalhesGlicemico: detalhe)
        navigationController?.pushViewController(vcDetalhes, animated: true)
    }

}






extension ConsultarDadosViewController: UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidAppear(_ animated: Bool) {
        if glicemias.count > 1 {
            let index = IndexPath(row: 1, section: 0)
            tableView.scrollToRow(at: index, at: .top, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return glicemias.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if (glicemias.count > 0) {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView = nil
            return 1;
            
        } else {
            
            let frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.height)
            let messageLabel = UILabel(frame: frame)
            
            messageLabel.text = "Não tem dados. Push down para reload.";
            messageLabel.textColor = UIColor.black
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font = textoFormato()
            messageLabel.sizeToFit()
            
            tableView.backgroundView = messageLabel;
            tableView.separatorStyle = .none;
            
        }
        
        return 0;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        let glicemia:Glicemia = glicemias[indexPath.row]
        
        let putGreen = glicemiaEhMaior(glicemia: glicemia)
        let putRed = glicemiaEhMenor(glicemia: glicemia)
        let color = Colors()
        
        if putGreen {
            cell.backgroundColor = color.getLightGreen()
        }
        if putRed {
            cell.backgroundColor = color.getRedLight()
        }
        
        cell.textLabel?.text = "Dados glicemicos: \(glicemia.valorGlicemico)"
        cell.detailTextLabel?.text = "data: \(dateFormatter.string(from: glicemia.dtCadastro as Date))"
        cell.textLabel?.font = textoFormato()
        
        
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(ConsultarDadosViewController.tapCell))
        cell.addGestureRecognizer(gestureTap)
        return cell
    }
    
    func tapCell(){
        print("Veiooo aki")
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let glicemia:Glicemia = glicemias[indexPath.row]
            glicemia.delete()
            glicemias.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let glicemia:Glicemia = glicemias[indexPath.row]
        print(glicemia)
        
        let configuracao = Configuracao()
        configuracao.id = glicemia.configuracao
        configuracao.configuracaoComId(realm: try! Realm())
        
        let glicemiaValue = glicemia.valorGlicemico.description
        let taxaHormonal = glicemia.taxaHormonal.description
        let pressao = "\(glicemia.pressaoMenor) por \(glicemia.pressaoMaior)"
        let observacao = glicemia.observacao
        
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        let dtExame = df.string(from: glicemia.dtCadastro as Date)
        
        let maiorGlicemia = configuracao.maiorGlicemia.description
        let menorGlicemia = configuracao.menorGlicemia.description
        
        let detalhe = DeatalheGlicemia(glicemia: glicemiaValue, taxaHormonal: taxaHormonal, pressao: pressao, observacao: observacao, dtExame: dtExame, maiorGlicemia: maiorGlicemia, menorGlicemia: menorGlicemia)
        
        goDetalheGlicemia(detalhe: detalhe)
        //self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        print("akii ooh")
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Vai deletar ?"
    }
    
}


//Animation with view
extension ConsultarDadosViewController {
    
    func configurarPushRefresh(){
        self.tableView.addSubview(self.refreshControl)
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        configurarDados()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
}


