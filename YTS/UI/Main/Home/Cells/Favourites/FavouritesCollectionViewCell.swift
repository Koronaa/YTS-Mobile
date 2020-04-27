//
//  FavouritesCollectionViewCell.swift
//  YTS
//
//  Created by Sajith Konara on 4/14/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit
import Kingfisher


class FavouritesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    var favouriteCellViewModel:FavouriteCellViewModel!{
        didSet{
            configure(for: self.favouriteCellViewModel.movieImageURL)
        }
    }
    
    func configure(for url:URL){
        setupCell()
        moviePosterImageView.kf.setImage(with: url)
    }
    
    private func setupCell(){
        UIHelper.addCornerRadius(to: holderView,withRadius: 15)
        UIHelper.addCornerRadius(to: moviePosterImageView, withRadius: 15)
    }
}
