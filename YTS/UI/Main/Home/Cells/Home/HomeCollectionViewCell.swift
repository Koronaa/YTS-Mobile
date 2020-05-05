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
    
    
    private func configure(with homeCVCellVM:HomeCellViewModel){
        setupUI()
        moviePosterImageView.kf.setImage(with: homeCVCellVM.imageURL)
        movietitleLabel.text = homeCVCellVM.title
        releasedYearLabel.text = homeCVCellVM.year
        durationLabel.text = homeCVCellVM.duration
        ratingLabel.text = homeCVCellVM.rating
    }
    
    private func setupUI(){
        UIHelper.roundCorners(view: moviePosterImageView, corners: [.topLeft,.topRight], radius: 15)
        UIHelper.addCornerRadius(to: holderView,withRadius: 15)
        UIHelper.roundCorners(view: bottomView, corners: [.bottomLeft,.bottomRight], radius: 15)
    }
    
    public static func dequeue(from collectionView:UICollectionView,for indexPath:IndexPath, with viewModel:HomeCellViewModel) -> HomeCollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UIConstants.Cell.HomeCollectionViewCell.rawValue, for: indexPath) as! HomeCollectionViewCell
        cell.configure(with: viewModel)
        return cell
    }
}
