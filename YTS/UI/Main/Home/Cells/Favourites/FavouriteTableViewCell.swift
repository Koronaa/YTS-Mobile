//
//  TableViewCell.swift
//  YTS
//
//  Created by Sajith Konara on 4/14/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import UIKit
import SkeletonView

protocol HomeCollectionViewDelegate {
    func didSelectItem(for movie:Movie)
}

class FavouriteTableViewCell:UITableViewCell,UICollectionViewDelegate,SkeletonCollectionViewDataSource{
    
    let homeVM:HomeViewModel = HomeViewModel()
    
    var favouritesCollectionView:UICollectionView!
    var section:Int!
    var collectionViewDelegate:HomeCollectionViewDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupFavouritesCollectionView()
        favouritesCollectionView.prepareSkeleton { isDone in
            self.favouritesCollectionView.showAnimatedGradientSkeleton()
            self.favouritesCollectionView.startSkeletonAnimation()
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    private func setupFavouritesCollectionView(){
        let favouriteLayout = UICollectionViewFlowLayout()
        favouriteLayout.scrollDirection = .horizontal
        favouriteLayout.itemSize = CGSize(width: 200, height: 300)
        favouriteLayout.minimumLineSpacing = 15
        
        favouritesCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 320), collectionViewLayout: favouriteLayout)
        if #available(iOS 13.0, *) {
            favouritesCollectionView.backgroundColor = .systemGray6
        } else {
            favouritesCollectionView.backgroundColor = .systemGray6Fallback
        }
        favouritesCollectionView.isSkeletonable = true
        favouritesCollectionView.showsHorizontalScrollIndicator = false
        favouritesCollectionView.contentMode = .center
        favouritesCollectionView.register(UINib(nibName: "FavouritesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: UIConstants.Cell.FavouritesCollectionViewCell.rawValue)
        favouritesCollectionView.dataSource = self
        favouritesCollectionView.delegate = self
        self.addSubview(favouritesCollectionView)
        
        homeVM.loadLatestMovies { 
            self.favouritesCollectionView.stopSkeletonAnimation()
            self.favouritesCollectionView.hideSkeleton()
            self.favouritesCollectionView.reloadData()
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeVM.latestMoves.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.section {
        case 0:
            let movie = homeVM.latestMoves[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UIConstants.Cell.FavouritesCollectionViewCell.rawValue, for: indexPath) as! FavouritesCollectionViewCell
            cell.favouriteCellViewModel = FavouriteCellViewModel(movie: movie)
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionViewDelegate?.didSelectItem(for: homeVM.latestMoves[indexPath.row])
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return UIConstants.Cell.FavouritesCollectionViewCell.rawValue
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
}
