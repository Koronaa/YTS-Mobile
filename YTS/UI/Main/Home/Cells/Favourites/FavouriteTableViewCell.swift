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
    
    fileprivate var homeVM:HomeViewModel!
    fileprivate var favouriteCollectionCellMaker:DependencyRegistryIMPL.FavouriteCollectionViewCellMaker!
    var collectionViewDelegate:HomeCollectionViewDelegate!
    
    
    var favouritesCollectionView:UICollectionView!
    var section:Int!
    
    
    func configure(homeVM:HomeViewModel,
                   favouriteCollectionCellMaker:@escaping DependencyRegistryIMPL.FavouriteCollectionViewCellMaker,
                   collectionViewDelegate:HomeCollectionViewDelegate){
        self.homeVM = homeVM
        self.favouriteCollectionCellMaker = favouriteCollectionCellMaker
        self.collectionViewDelegate = collectionViewDelegate
        
        homeVM.loadLatestMovies {
            self.favouritesCollectionView.stopSkeletonAnimation()
            self.favouritesCollectionView.hideSkeleton()
            self.favouritesCollectionView.reloadData()
        }
    }
    
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
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeVM.latestMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.section {
        case 0:
            let movie = homeVM.latestMovies[indexPath.row]
            let cell = favouriteCollectionCellMaker(collectionView,indexPath,movie)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionViewDelegate.didSelectItem(for: homeVM.latestMovies[indexPath.row])
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return UIConstants.Cell.FavouritesCollectionViewCell.rawValue
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    public static func dequeue(from tableView:UITableView,for indexPath:IndexPath) -> FavouriteTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.Cell.FavouriteTableViewCell.rawValue, for: indexPath) as! FavouriteTableViewCell
        cell.section = indexPath.section
        return cell
    }
    
    
}
