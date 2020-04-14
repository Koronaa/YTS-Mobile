//
//  HomeCollectionViewCell.swift
//  YTS
//
//  Created by Sajith Konara on 4/14/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movietitleLabel: UILabel!
    @IBOutlet weak var releasedYearLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    func configure(){
        setupUI()
        moviePosterImageView.kf.setImage(with: URL(string: "https://yts.mx/assets/images/movies/ultimate_avengers_2006/large-cover.jpg"))
    }
    
    private func setupUI(){
        UIHelper.roundCorners(view: moviePosterImageView, corners: [.topLeft,.topRight], radius: 15)
        UIHelper.addCornerRadius(to: holderView,withRadius: 15)
        UIHelper.roundCorners(view: bottomView, corners: [.bottomLeft,.bottomRight], radius: 15)
    }
    
}
