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
    
    
    var castCellViewModel:CastCellViewModel!{
        didSet{
            setupCell()
            castImageView.kf.setImage(with:castCellViewModel.imageURL)
            castNameLabel.text = castCellViewModel.name
        }
    }
    
    private func setupCell(){
        UIHelper.circular(view: castImageView)
    }
    

}
