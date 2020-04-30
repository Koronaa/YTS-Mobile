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
    
    
    func getMostRatedMovies(limit:Int,pageNo:Int,onCompleted:@escaping (_ movies:[Movie],_ data:Data)->Void){
        let url = URL(string: String(format: URLConstants.Api.Path.getMostRatedMovies, limit.description,pageNo.description).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        networkLayer.getMoviesJSON(for: url!) { responseJSON in
            let (data,movies) = self.translationLayer.getMovies(from: responseJSON)
            onCompleted(movies,data)
        }
    }
    
    func getLatestMovies(limit:Int,pageNo:Int,onCompleted:@escaping (_ movies:[Movie],_ data:Data)->Void){
        let url = URL(string: String(format: URLConstants.Api.Path.getLatestMovies, limit.description,pageNo.description).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        networkLayer.getMoviesJSON(for: url!) { responseJSON in
            let (data,movies) = self.translationLayer.getMovies(from: responseJSON)
            onCompleted(movies,data)
        }
    }
    
    func getPopularMovies(limit:Int,pageNo:Int,onCompleted:@escaping (_ movies:[Movie],_ data:Data)->Void){
        let url = URL(string: String(format: URLConstants.Api.Path.getPopularMovies, limit.description,pageNo.description).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        networkLayer.getMoviesJSON(for: url!) { responseJSON in
            let (data,movies) = self.translationLayer.getMovies(from: responseJSON)
            onCompleted(movies,data)
        }
    }
    
    func getCastDetails(for movieID:String,onCompleted:@escaping (_ casts:[Cast])->Void){
        let url = URL(string: String(format: URLConstants.Api.Path.getMovieDetails, movieID).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        networkLayer.getMoviesJSON(for: url!) { responseJSON in
            onCompleted(self.translationLayer.getCastDetails(from: responseJSON))
        }
    }
    
    
    func searchMovies(for query:String,quality:String,genre:String,rating:String,orderBy:String,pageNo:Int,limit:Int,onCompleted:@escaping (_ movies:[Movie],_ data:Data)-> Void){
        let url = URL(string: String(format: URLConstants.Api.Path.searchMovies, query,quality,genre,rating,orderBy,pageNo.description,limit.description).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        networkLayer.getMoviesJSON(for: url!) { responseJSON in
            let (data,movies) = self.translationLayer.getMovies(from: responseJSON)
            onCompleted(movies,data)
        }
    }
    
    
}
