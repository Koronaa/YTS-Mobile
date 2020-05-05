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
    
    private func configure(with viewModel:FavouriteCellViewModel){
        setupCell()
        moviePosterImageView.kf.setImage(with: viewModel.movieImageURL)
    }
    
    private func setupCell(){
        UIHelper.addCornerRadius(to: holderView,withRadius: 15)
        UIHelper.addCornerRadius(to: moviePosterImageView, withRadius: 15)
    }
    
    public static func dequeue(from collectionView:UICollectionView,for indexPath:IndexPath, with viewModel:FavouriteCellViewModel) -> FavouritesCollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UIConstants.Cell.FavouritesCollectionViewCell.rawValue, for: indexPath) as! FavouritesCollectionViewCell
        cell.configure(with: viewModel)
        return cell
        
    }
}
