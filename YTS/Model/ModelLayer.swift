//
//  ModelLayer.swift
//  YTS
//
//  Created by Sajith Konara on 4/27/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import SwiftyJSON

class ModelLayer{
    
    fileprivate let networkLayer:NetworkLayer = NetworkLayer()
    fileprivate let translationLayer:TranslationLayer = TranslationLayer()
    
//    init(networkLayer:NetworkLayer,translationLayer:TranslationLayer) {
//        self.networkLayer = networkLayer
//        self.translationLayer = translationLayer
//    }
    
    
    func getMostRatedMovies(onCompleted:@escaping (_ movies:[Movie])->Void){
        networkLayer.getMoviesJSON(for: URL(string: URLConstants.Api.Path.getMostRatedMovies)!) { responseJSON in
            onCompleted(self.translationLayer.getMovies(from: responseJSON))
        }
    }
    
    func getLatestMovies(onCompleted:@escaping (_ movies:[Movie])->Void){
        networkLayer.getMoviesJSON(for: URL(string: URLConstants.Api.Path.getLatestMovies)!) { responseJSON in
            onCompleted(self.translationLayer.getMovies(from: responseJSON))
        }
    }
    
    func getPopularMovies(onCompleted:@escaping (_ movies:[Movie])->Void){
        networkLayer.getMoviesJSON(for: URL(string: URLConstants.Api.Path.getPopularMovies)!) { responseJSON in
            onCompleted(self.translationLayer.getMovies(from: responseJSON))
        }
    }
    
    func getCastDetails(for movieID:String,onCompleted:@escaping (_ casts:[Cast])->Void){
        let url = URL(string: String(format: URLConstants.Api.Path.getMovieDetails, movieID))
        networkLayer.getMoviesJSON(for: url!) { responseJSON in
            onCompleted(self.translationLayer.getCastDetails(from: responseJSON))
        }
    }
    
    
    func searchMovies(for query:String,quality:String,genre:String,rating:String,orderBy:String,onCompleted:@escaping (_ movies:[Movie])-> Void){
        let url = URL(string: String(format: URLConstants.Api.Path.searchMovies, query,quality,genre,rating,orderBy))
        networkLayer.getMoviesJSON(for: url!) { responseJSON in
            onCompleted(self.translationLayer.getMovies(from: responseJSON))
        }
    }
    
    
}
