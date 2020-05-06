//
//  HomeTableViewCell.swift
//  YTS
//
//  Created by Sajith Konara on 4/14/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import UIKit
import SkeletonView

class HomeTableViewCell:UITableViewCell,UICollectionViewDelegate,SkeletonCollectionViewDataSource{
    
    var homeCollectionView:UICollectionView!
    var section:Int!
    
    fileprivate var homeCollectionViewCellMaker:DependencyRegistryIMPL.HomeCollectionViewCellMaker!
    fileprivate var homeVM:HomeViewModel!
    var collectionViewDelegate:HomeCollectionViewDelegate!
    
    func congifure(homeCollectionViewCellMaker:@escaping DependencyRegistryIMPL.HomeCollectionViewCellMaker,
                   collectionViewDelegate:HomeCollectionViewDelegate){
        self.homeCollectionViewCellMaker = homeCollectionViewCellMaker
        self.collectionViewDelegate = collectionViewDelegate
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHomeCollectionView()
        homeCollectionView.prepareSkeleton { isDone in
            self.homeCollectionView.showAnimatedGradientSkeleton()
            self.homeCollectionView.startSkeletonAnimation()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(didHomeDataLoad(_:)), name: NotificationConstants.Keys.HOME_DATA_LOADED, object: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    @objc func didHomeDataLoad(_ notification:Notification) {
        self.homeVM = (notification.userInfo!["homeVM"] as! HomeViewModel)
        self.homeCollectionView.stopSkeletonAnimation()
        self.homeCollectionView.hideSkeleton()
        self.homeCollectionView.reloadData()
    }
    
    
    private func setupHomeCollectionView(){
        
        let homeLayout = UICollectionViewFlowLayout()
        homeLayout.scrollDirection = .horizontal
        homeLayout.itemSize = CGSize(width: 167, height: 365)
        homeLayout.minimumLineSpacing = 15
        
        homeCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 385), collectionViewLayout: homeLayout)
        if #available(iOS 13.0, *) {
            homeCollectionView.backgroundColor = .systemGray6
        } else {
            homeCollectionView.backgroundColor = .systemGray6Fallback
        }
        homeCollectionView.isSkeletonable = true
        homeCollectionView.showsHorizontalScrollIndicator = false
        homeCollectionView.contentMode = .center
        homeCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: UIConstants.Cell.HomeCollectionViewCell.rawValue)
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
        self.addSubview(homeCollectionView)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.section {
        case 1:
            return homeVM.popularMovies.count
        case 2:
            return homeVM.topRatedMovies.count
        default:()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var movie:Movie!
        switch self.section {
        case 1:
            movie = homeVM.popularMovies[indexPath.row]
        case 2:
            movie = homeVM.topRatedMovies[indexPath.row]
        default:()
        }
        let cell = homeCollectionViewCellMaker(collectionView,indexPath,movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var movie:Movie!
        switch self.section {
        case 1:
            movie = homeVM.popularMovies[indexPath.row]
        case 2:
            movie = homeVM.topRatedMovies[indexPath.row]
        default:()
        }
        collectionViewDelegate.didSelectItem(for: movie)
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return UIConstants.Cell.HomeCollectionViewCell.rawValue
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    public static func dequeue(from tableView:UITableView,for indexPath:IndexPath) -> HomeTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.Cell.HomeTableViewCell.rawValue, for: indexPath) as! HomeTableViewCell
        cell.section = indexPath.section
        return cell
    }
}

