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
    var topRatedMovies:[Movie] = []
    var popularMovies: [Movie] = []
    fileprivate var modelLayer:ModelLayer = ModelLayer()
    
    
    func loadLatestMovies(limit:Int = 10,onCompleted:@escaping(_ movies:[Movie])->Void){
        modelLayer.getLatestMovies(limit: limit) { latestMovies in
            self.latestMoves = latestMovies
            onCompleted(latestMovies)
        }
    }
    
    func loadHomeMovies(onCompleted:@escaping()->Void){
        loadPopularMovies { popularMovies in
            self.popularMovies = popularMovies
            self.loadMostRatedMovies { mostRatedMovies in
                self.topRatedMovies = mostRatedMovies
                onCompleted()
            }
        }
    }
    
    
    func loadMostRatedMovies(limit:Int = 10,onCompleted:@escaping (_ movies:[Movie])->Void){
        modelLayer.getMostRatedMovies(limit: limit) { movies in
            onCompleted(movies)
        }
    }
    
    
    func loadPopularMovies(limit:Int = 10,onCompleted:@escaping (_ movies:[Movie])->Void){
        modelLayer.getPopularMovies(limit: limit) { movies in
            onCompleted(movies)
        }
    }
}

