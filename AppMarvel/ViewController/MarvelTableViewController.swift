//
//  MarvelTableViewController.swift
//  AppMarvel
//
//  Created by Lucas Mendes on 29/09/2019.
//  Copyright © 2019 lucas  mendes. All rights reserved.
//

import UIKit

class MarvelTableViewController: UITableViewController {
    
    var herois: [Hero] = []
    var loadHerois = false
    var currentPage = 0
    var totalPages = 0
    var heroiSelecionado: Hero?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Buscando heróis..."
        carregaHerois()
    }
    
    func carregaHerois() {
        loadHerois = true
        MarvelApi.loadHeros(page: currentPage) { (info) in
            if let info = info {
                self.herois += info.data.results
                self.totalPages = info.data.total
            
                DispatchQueue.main.async {
                    self.label.text = "Não foram encontrados Heróis."
                    self.loadHerois = false
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        tableView.backgroundView = herois.count == 0 ? label: nil
        return herois.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MarvelTableViewCell
        
        let heroi = herois[indexPath.row]
        cell.prepareCell(with: heroi)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == herois.count - 10 && !loadHerois && herois.count != totalPages{
            currentPage += 1
            carregaHerois()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.heroiSelecionado = self.herois[indexPath.row]
        self.performSegue(withIdentifier: "ShowDetalheID", sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetalheID" {
            let vcDetalhe = segue.destination as! DetalheViewController
            vcDetalhe.heroiSelecionado = self.heroiSelecionado
        }
    }

}
