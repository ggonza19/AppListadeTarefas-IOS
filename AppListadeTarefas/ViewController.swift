//
//  ViewController.swift
//  AppListadeTarefas
//
//  Created by COTEMIG on 19/08/20.
//  Copyright © 2020 Cotemig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var listadetarefas: [String] = []
    let keyLista = "listadetarefas"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        if let lista = UserDefaults.standard.value(forKey: keyLista) as? [String] {
            listadetarefas.append(contentsOf: lista)
        }
    }
    


    @IBAction func addTask(_ sender: Any) {
        let alert = UIAlertController(title: "Nova Tarefa", message:"Adicione uma Tarefa", preferredStyle: . alert)
        
        
        let acaoSalvar = UIAlertAction(title: "Salvar", style: .default) { (action) in
            
            if let textField = alert.textFields?.first, let texto = textField.text {
                self.listadetarefas.append(texto)
                self.tableView.reloadData()
                UserDefaults.standard.set(self.listadetarefas, forKey: self.keyLista)
            }
        }
        
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel) { (action) in
            print("clicou em cancelar")
        }
        alert.addAction(acaoSalvar)
        alert.addAction(acaoCancelar)
        alert.addTextField()
        
        
        
        present(alert, animated: true)
    }
    
 
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listadetarefas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = listadetarefas[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            listadetarefas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(self.listadetarefas, forKey: keyLista)
        
        }
    }
}


