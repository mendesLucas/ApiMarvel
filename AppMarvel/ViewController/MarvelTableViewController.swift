//
//  MarvelTableViewController.swift
//  AppMarvel
//
//  Created by Lucas Mendes on 29/09/2019.
//  Copyright © 2019 lucas  mendes. All rights reserved.
//

import UIKit

class MarvelTableViewController: UITableViewController {
    
    private var marvelVM = MarvelViewModel()
    var heroiSelecionado: Hero?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.marvelVM.label.text = "Buscando heróis..."
        setupViewModel()
    }
    private func setupViewModel() {
        
        //Carrega tela com a lista de eventos
        self.marvelVM.carregaHerois()
        self.marvelVM.reloadView = {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        tableView.backgroundView = self.marvelVM.herois.count == 0 ? self.marvelVM.label: nil
        return self.marvelVM.herois.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MarvelTableViewCell
        
        let heroi = self.marvelVM.herois[indexPath.row]
        cell.prepareCell(with: heroi)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.marvelVM.herois.count - 10 && !self.marvelVM.loadHerois && self.marvelVM.herois.count != self.marvelVM.totalPages{
            self.marvelVM.currentPage += 1
            self.marvelVM.carregaHerois()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.heroiSelecionado = self.marvelVM.herois[indexPath.row]
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
