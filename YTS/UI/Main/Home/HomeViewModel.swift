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
    var latestMovieData:Data!
    var topRatedMovies:[Movie] = []
    var topRatedMoviesData:Data!
    var popularMovies: [Movie] = []
    var popularMoviesData:Data!
    
    fileprivate var commonViewModel:CommonViewModel
    
    init(commonViewModel:CommonViewModel) {
        self.commonViewModel = commonViewModel
    }
    
    func loadLatestMovies(onCompleted:@escaping()->Void){
        commonViewModel.loadLatestMovies { (latestMovies, data) in
            self.latestMovies = latestMovies
            self.latestMovieData = data
            onCompleted()
        }
    }
    
    func loadHomeMovies(onCompleted:@escaping()->Void){
        commonViewModel.loadPopularMovies { popularMovies,data in
            self.popularMovies = popularMovies
            self.popularMoviesData = data
            self.commonViewModel.loadMostRatedMovies { topRatedMovies,data in
                self.topRatedMovies = topRatedMovies
                self.topRatedMoviesData = data
                onCompleted()
            }
        }
    }
}

