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
    
    
//    init(modelLayer:ModelLayer) {
//        self.modelLayer = modelLayer
//    }
    
    
    func loadLatestMovies(onCompleted:@escaping(_ movies:[Movie])->Void){
        modelLayer.getLatestMovies { latestMovies in
            self.latestMoves = latestMovies
            onCompleted(latestMovies)
        }
    }
    
    func loadHomeMovies(onCompleted:@escaping(_ movies:[Movie])->Void){
        modelLayer.getPopularMovies { popularMovies in
            self.popularMovies = popularMovies
            self.modelLayer.getMostRatedMovies { mostRatedMovies in
                self.topRatedMovies = mostRatedMovies
                onCompleted(mostRatedMovies)
            }
        }
    }
}

