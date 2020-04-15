//
//  HomeTableViewCell.swift
//  YTS
//
//  Created by Sajith Konara on 4/14/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import UIKit

class HomeTableViewCell:UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var homeCollectionView:UICollectionView!
    var section:Int!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHomeCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupHomeCollectionView(){
        let homeLayout = UICollectionViewFlowLayout()
        homeLayout.scrollDirection = .horizontal
        homeLayout.itemSize = CGSize(width: 167, height: 365)
        homeLayout.minimumLineSpacing = 15
        
        homeCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - 30.0, height: 385), collectionViewLayout: homeLayout)
        if #available(iOS 13.0, *) {
            homeCollectionView.backgroundColor = .systemGray6
        } else {
            // Fallback on earlier versions
        }
        homeCollectionView.showsHorizontalScrollIndicator = false
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
        case 1,2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UIConstants.Cell.HomeCollectionViewCell.rawValue, for: indexPath) as! HomeCollectionViewCell
            cell.configure()
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
    
    
    
}

