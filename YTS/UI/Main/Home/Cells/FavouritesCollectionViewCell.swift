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
    
    func configure(){
        setupCell()
        moviePosterImageView.kf.setImage(with: URL(string: "https://yts.mx/assets/images/movies/batman_hush_2019/large-cover.jpg"))
    }
    
    private func setupCell(){
        UIHelper.addCornerRadius(to: holderView,withRadius: 15)
        UIHelper.addCornerRadius(to: moviePosterImageView, withRadius: 15)
    }
}
