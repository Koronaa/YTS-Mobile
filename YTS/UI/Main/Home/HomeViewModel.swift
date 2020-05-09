//
//  HomeViewModel.swift
//  YTS
//
//  Created by Sajith Konara on 4/27/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

class HomeViewModel{
    
    var latestMovies:[Movie] = []
    var latestMovieData:ResultData!
    var topRatedMovies:[Movie] = []
    var topRatedMoviesData:ResultData!
    var popularMovies: [Movie] = []
    var popularMoviesData:ResultData!
    
    fileprivate var commonViewModel:CommonViewModel
    
    init(commonViewModel:CommonViewModel) {
        self.commonViewModel = commonViewModel
    }
    
    func loadLatestMovies(onCompleted:@escaping()->Void){
        commonViewModel.loadLatestMovies { moviesData in
            self.latestMovies = moviesData.movies!
            self.latestMovieData = ResultData(limit: moviesData.limit, pageNo: moviesData.pageNumber, movieCount: moviesData.movieCount)
            onCompleted()
        }
    }
    
    func loadHomeMovies(onCompleted:@escaping()->Void){
        commonViewModel.loadPopularMovies { moviesData in
            self.popularMovies = moviesData.movies!
            self.popularMoviesData = ResultData(limit: moviesData.limit, pageNo: moviesData.pageNumber, movieCount: moviesData.movieCount)
            self.commonViewModel.loadMostRatedMovies { moviesData in
                self.topRatedMovies = moviesData.movies!
                self.topRatedMoviesData = ResultData(limit: moviesData.limit, pageNo: moviesData.pageNumber, movieCount: moviesData.movieCount)
                onCompleted()
            }
        }
    }
}

