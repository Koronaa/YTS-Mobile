//
//  MovieListViewController.swift
//  YTS
//
//  Created by Sajith Konara on 4/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit
import SkeletonView

enum MovieListType{
    case SEARCH
    case LATEST
    case POPULAR
    case RATED
}

class MovieListViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTItleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var movieListVM:MovieListViewModel!
    
    
    func configure(with movieListVM:MovieListViewModel){
        self.movieListVM = movieListVM
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: UIConstants.Cell.HomeCollectionViewCell.rawValue)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isSkeletonable = true
        collectionView.prepareSkeleton { isDone in
            self.collectionView.showAnimatedGradientSkeleton()
            self.collectionView.startSkeletonAnimation()
        }
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI(for: movieListVM.movieListType)
    }
    
    
    
    private func setupUI(for type:MovieListType){
        switch DeviceManager.getDeviceType() {
        case .iPhone_6_6s_7_8,.iPhone_X_Xs_11Pro:
            let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 10)
        default:()
        }
        
        UIHelper.addCornerRadius(to: backButton)
        
        
        UIHelper.roundCorners(view: bottomView, corners: [.topLeft,.topRight], radius: 25)
        switch type {
        case .SEARCH:
            titleLabel.text = "Search Results"
            if movieListVM.searchViewModel!.queryString != ""{
                subTItleLabel.text = "Showing results for '\(movieListVM.searchViewModel!.queryString)'"
            }else{
                subTItleLabel.isHidden = true
            }
        case .LATEST:
            titleLabel.text = "Latest Movies"
            subTItleLabel.text = "Showing the latest uploads on YTS"
        case .POPULAR:
            titleLabel.text = "Popular Movies"
            subTItleLabel.text = "Showing most popular movies on YTS"
        case .RATED:
            titleLabel.text = "Top Rated Movies"
            subTItleLabel.text = "Showing the highest IMDB rated movies"
        }
    }
    
    func loadData(){
        movieListVM.loadData {
            self.collectionView.stopSkeletonAnimation()
            self.collectionView.hideSkeleton()
            self.collectionView.reloadData()
        }
    }
    
    
    @IBAction func backButtonOnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MovieListViewController:UICollectionViewDelegate,SkeletonCollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieListVM.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = movieListVM.movies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UIConstants.Cell.HomeCollectionViewCell.rawValue, for: indexPath) as! HomeCollectionViewCell
        cell.homeCVCellVM = HomeCellViewModel(movie: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movieListVM.movies[indexPath.row]
        let movieDetailsVM = MovieDetailsViewModel(movie: movie)
        let movieDetailsVC = UIHelper.makeViewController(in: .Main, viewControllerName: .MovieDetailsVC) as! MovieDetailViewController
        movieDetailsVC.movieDetailsVM = movieDetailsVM
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movieListVM.totalMovies - 4{
            if movieListVM.currentPage + 1 <= movieListVM.totalNoOfPages{
                movieListVM.data!.pageNo = movieListVM.currentPage + 1
                loadData()
            }
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return UIConstants.Cell.HomeCollectionViewCell.rawValue
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}
