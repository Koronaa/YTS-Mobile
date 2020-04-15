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
    
    var favouritesCollectionView:UICollectionView!
    var section:Int!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupFavouritesCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupFavouritesCollectionView(){
        let favouriteLayout = UICollectionViewFlowLayout()
        favouriteLayout.scrollDirection = .horizontal
        favouriteLayout.itemSize = CGSize(width: 200, height: 300)
        favouriteLayout.minimumLineSpacing = 15
        
        favouritesCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 30.0, height: 320), collectionViewLayout: favouriteLayout)
        if #available(iOS 13.0, *) {
            favouritesCollectionView.backgroundColor = .systemGray6
        } else {
            // Fallback on earlier versions
        }
        favouritesCollectionView.showsHorizontalScrollIndicator = false
        favouritesCollectionView.contentMode = .center
        favouritesCollectionView.register(UINib(nibName: "FavouritesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: UIConstants.Cell.FavouritesCollectionViewCell.rawValue)
        favouritesCollectionView.dataSource = self
        favouritesCollectionView.delegate = self
        self.addSubview(favouritesCollectionView)
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
        default:
            return UICollectionViewCell()
        }
    }
}
