//
//  TableViewCell.swift
//  YTS
//
//  Created by Sajith Konara on 4/14/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import UIKit

class FavouriteTableViewCell:UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var favouritesCollectionView,homeCollectionView:UICollectionView!
    var section:Int!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCollectionViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupCollectionViews(){
        setupFavouritesCollectionView()
        setupHomeCollectionView()
    }
    
    private func setupFavouritesCollectionView(){
        let favouriteLayout = UICollectionViewFlowLayout()
        favouriteLayout.scrollDirection = .horizontal
        favouriteLayout.itemSize = CGSize(width: 180, height: 250)
        
        favouritesCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 260), collectionViewLayout: favouriteLayout)
        favouritesCollectionView.backgroundColor = .clear
        favouritesCollectionView.contentMode = .center
        favouritesCollectionView.register(UINib(nibName: "FavouritesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: UIConstants.Cell.FavouritesCollectionViewCell.rawValue)
        homeCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: UIConstants.Cell.HomeCollectionViewCell.rawValue)
        favouritesCollectionView.dataSource = self
        favouritesCollectionView.delegate = self
        self.addSubview(favouritesCollectionView)
    }
    
    private func setupHomeCollectionView(){
        let homeLayout = UICollectionViewFlowLayout()
        homeLayout.scrollDirection = .horizontal
        homeLayout.itemSize = CGSize(width: 205, height: 290)
        
        homeCollectionView = UICollectionView(frame: CGRect(x: 0, y: 300, width: UIScreen.main.bounds.size.width, height: 300), collectionViewLayout: homeLayout)
        homeCollectionView.backgroundColor = .clear
        homeCollectionView.contentMode = .center
        homeCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: UIConstants.Cell.HomeCollectionViewCell.rawValue)
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
        self.addSubview(homeCollectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UIConstants.Cell.FavouritesCollectionViewCell.rawValue, for: indexPath) as! FavouritesCollectionViewCell
            cell.configure()
            return cell
        case 1,2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UIConstants.Cell.HomeCollectionViewCell.rawValue, for: indexPath) as! HomeCollectionViewCell
            cell.configure()
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
    
    
    
}
