//
//  CastCollectionViewCell.swift
//  YTS
//
//  Created by Sajith Konara on 4/16/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit
import Kingfisher

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    
    
    func configure(){
        setupCell()
        castNameLabel.text = "Jennifer Morrison"
        
        castImageView.kf.setImage(with: URL(string: "https://yts.mx/assets/images/actors/thumb/nm0607185.jpg"))
    }
    
    
    private func setupCell(){
        UIHelper.circular(view: castImageView)
    }
    

}
