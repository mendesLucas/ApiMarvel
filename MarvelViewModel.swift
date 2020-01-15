//
//  MarvelViewModel.swift
//  AppMarvel
//
//  Created by lucas mendes on 15/01/20.
//  Copyright © 2020 lucas  mendes. All rights reserved.
//

import Foundation
import UIKit
typealias DataHandler = () -> Void

class MarvelViewModel {
    var herois: [Hero] = []
    var currentPage = 0
    var loadHerois = false
    var totalPages = 0
    var reloadView: DataHandler = { }
    
    func carregaHerois() {
        loadHerois = true
        MarvelApi.loadHeros(page: currentPage) { (info) in
            if let info = info {
                self.herois += info.data.results
                self.totalPages = info.data.total
            
                DispatchQueue.main.async {
                    self.label.text = "Não foram encontrados Heróis."
                    self.loadHerois = false
                    self.reloadView()
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
}
