//
//  MovieListViewController.swift
//  YTS
//
//  Created by Sajith Konara on 4/18/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import UIKit

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
    
    fileprivate var movieListVM = MovieListViewModel()
    fileprivate var homeVM = HomeViewModel()
    var movieSearchVM:SearchViewModel!
    
    var type:MovieListType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: UIConstants.Cell.HomeCollectionViewCell.rawValue)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI(for: type)
    }
    
    private func setupUI(for type:MovieListType){
        switch type {
        case .SEARCH:
            titleLabel.text = "Search Results"
            if movieSearchVM.queryString != ""{
                subTItleLabel.text = "Showing results for '\(movieSearchVM.queryString)'"
            }else{
                subTItleLabel.isHidden = true
                //TODO
            }
            movieSearchVM.search { movies in
                self.movieListVM.movies = movies
                self.collectionView.reloadData()
            }
        case .LATEST:
            titleLabel.text = "Latest Movies"
            subTItleLabel.text = "Showing the latest uploads on YTS"
            
            homeVM.loadLatestMovies(limit: 50) { movies in
                self.movieListVM.movies = movies
                self.collectionView.reloadData()
            }
            
        case .POPULAR:
            titleLabel.text = "Popular Movies"
            subTItleLabel.text = "Showing most popular movies on YTS"
            
            homeVM.loadPopularMovies(limit: 50) { movies in
                self.movieListVM.movies = movies
                self.collectionView.reloadData()
            }
        case .RATED:
            titleLabel.text = "Top Rated Movies"
            subTItleLabel.text = "Showing the highest IMDB rated movies"
            homeVM.loadMostRatedMovies(limit: 50) { movies in
                self.movieListVM.movies = movies
                self.collectionView.reloadData()
            }
        }
        
        UIHelper.roundCorners(view: bottomView, corners: [.topLeft,.topRight], radius: 25)
    }
    
    
    @IBAction func backButtonOnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension MovieListViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
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
    
    
    
    
}
