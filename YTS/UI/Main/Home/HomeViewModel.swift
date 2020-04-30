//
//  HomeViewModel.swift
//  YTS
//
//  Created by Sajith Konara on 4/27/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

class HomeViewModel{
    
    var latestMoves:[Movie] = []
    var latestMovieData:Data!
    var topRatedMovies:[Movie] = []
    var topRatedMoviesData:Data!
    var popularMovies: [Movie] = []
    var popularMoviesData:Data!
    fileprivate var modelLayer:ModelLayer = ModelLayer()
    
    
    func loadLatestMovies(limit:Int = 10,pageNo:Int = 1,onCompleted:@escaping()->Void){
        modelLayer.getLatestMovies(limit: limit, pageNo: pageNo) { latestMovies,data  in
            self.latestMoves = latestMovies
            self.latestMovieData = data
            onCompleted()
        }
    }
    
    func loadHomeMovies(onCompleted:@escaping()->Void){
        loadPopularMovies {
            self.loadMostRatedMovies {
                onCompleted()
            }
        }
    }
    
    
    func loadMostRatedMovies(limit:Int = 10,pageNo:Int = 1,onCompleted:@escaping ()->Void){
        modelLayer.getMostRatedMovies(limit: limit, pageNo: pageNo) { movies,data in
            self.topRatedMovies = movies
            self.topRatedMoviesData = data
            onCompleted()
        }
    }
    
    
    func loadPopularMovies(limit:Int = 10,pageNo:Int = 1,onCompleted:@escaping ()->Void){
        modelLayer.getPopularMovies(limit: limit, pageNo: pageNo) { movies,data in
            self.popularMovies = movies
            self.popularMoviesData = data
            onCompleted()
        }
    }
}

