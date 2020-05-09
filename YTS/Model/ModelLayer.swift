//
//  ModelLayer.swift
//  YTS
//
//  Created by Sajith Konara on 4/27/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

typealias MoviesResponseBlock = (MoviesResponse)->Void
typealias MovieDetailsResponseBlock = (MovieResponse)->Void

protocol ModelLayer {
    func getMostRatedMovies(limit:Int,pageNo:Int,onCompleted:@escaping MoviesResponseBlock)
    func getLatestMovies(limit:Int,pageNo:Int,onCompleted:@escaping MoviesResponseBlock)
    func getPopularMovies(limit:Int,pageNo:Int,onCompleted:@escaping MoviesResponseBlock)
    func getMovieDetails(for movieID:String,onCompleted:@escaping MovieDetailsResponseBlock)
    func searchMovies(for query:String,quality:String,genre:String,rating:String,orderBy:String,pageNo:Int,limit:Int,onCompleted:@escaping MoviesResponseBlock)
}


class ModelLayerIMPL:ModelLayer{
    
    fileprivate let networkLayer:NetworkLayerIMPL
    fileprivate let translationLayer:TranslationLayer
    
    init(networkLayer:NetworkLayerIMPL,translationLayer:TranslationLayer) {
        self.networkLayer = networkLayer
        self.translationLayer = translationLayer
    }
    
    
    func getMostRatedMovies(limit:Int,pageNo:Int,onCompleted:@escaping MoviesResponseBlock){
        let url = URL(string: String(format: URLConstants.Api.Path.getMostRatedMovies, limit.description,pageNo.description).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        networkLayer.getResponseJSON(for: url!) { responseData in
            self.translationLayer.getMovies(from: responseData) { moviesResponse in
                onCompleted(moviesResponse)
            }
        }
    }
    
    func getLatestMovies(limit:Int,pageNo:Int,onCompleted:@escaping MoviesResponseBlock){
        let url = URL(string: String(format: URLConstants.Api.Path.getLatestMovies, limit.description,pageNo.description).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        networkLayer.getResponseJSON(for: url!) { responseData in
            self.translationLayer.getMovies(from: responseData) { moviesResponse in
                onCompleted(moviesResponse)
            }
        }
    }
    
    func getPopularMovies(limit:Int,pageNo:Int,onCompleted:@escaping MoviesResponseBlock){
        let url = URL(string: String(format: URLConstants.Api.Path.getPopularMovies, limit.description,pageNo.description).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        networkLayer.getResponseJSON(for: url!) { responseData in
            self.translationLayer.getMovies(from: responseData) { moviesResponse in
                onCompleted(moviesResponse)
            }
        }
    }
    
    func getMovieDetails(for movieID:String,onCompleted:@escaping MovieDetailsResponseBlock){
        let url = URL(string: String(format: URLConstants.Api.Path.getMovieDetails, movieID).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        networkLayer.getResponseJSON(for: url!) { responseData in
            self.translationLayer.getMovieDetails(from: responseData) { movieResponse in
                onCompleted(movieResponse)
            }
        }
    }
    
    func searchMovies(for query:String,quality:String,genre:String,rating:String,orderBy:String,pageNo:Int,limit:Int,onCompleted:@escaping MoviesResponseBlock){
        let url = URL(string: String(format: URLConstants.Api.Path.searchMovies, query,quality,genre,rating,orderBy,pageNo.description,limit.description).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        networkLayer.getResponseJSON(for: url!) { responseData in
            self.translationLayer.getMovies(from: responseData) { moviesResponse in
                onCompleted(moviesResponse)
            }
        }
    }
}
