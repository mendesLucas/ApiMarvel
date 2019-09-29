//
//  HomeViewController.swift
//  AppMarvel
//
//  Created by Lucas Mendes on 29/09/2019.
//  Copyright © 2019 lucas  mendes. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // Criado segue para preparar envio de informação.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ModelEntrarID" {
        }
    }

}
