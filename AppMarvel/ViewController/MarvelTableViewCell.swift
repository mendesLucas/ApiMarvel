//
//  MarvelTableViewCell.swift
//  AppMarvel
//
//  Created by Lucas Mendes on 29/09/2019.
//  Copyright © 2019 lucas  mendes. All rights reserved.
//

import UIKit
import Kingfisher

class MarvelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgThumb: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescricao: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func prepareCell(with hero: Hero){
        lblName.text = hero.name
        lblDescricao.text = hero.description
        
        if let url = URL(string: hero.thumbnail.url){
            imgThumb.kf.indicatorType = .activity
            imgThumb.kf.setImage(with: url)
        }else{
            imgThumb.image = nil
        }
        
        imgThumb.layer.cornerRadius = imgThumb.frame.size.height/2
        imgThumb.layer.borderColor = UIColor.red.cgColor
        imgThumb.layer.borderWidth = 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgThumb.image = nil
    }
}
