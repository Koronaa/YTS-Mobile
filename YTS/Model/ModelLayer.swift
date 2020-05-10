//
//  ModelLayer.swift
//  YTS
//
//  Created by Sajith Konara on 4/27/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import RxSwift

typealias MoviesResponseBlock = (Observable<(MoviesResponse?,Error?)>)->Void
typealias MovieDetailsResponseBlock = (Observable<(MovieResponse?,Error?)>)->Void

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
    fileprivate let bag = DisposeBag()
    
    init(networkLayer:NetworkLayerIMPL,translationLayer:TranslationLayer) {
        self.networkLayer = networkLayer
        self.translationLayer = translationLayer
    }
    
    
    func getMostRatedMovies(limit:Int,pageNo:Int,onCompleted:@escaping MoviesResponseBlock){
        let url = URL(string: String(format: URLConstants.Api.Path.getMostRatedMovies, limit.description,pageNo.description).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        getMoviesResponse(for: url!) { (moviesResponseObservable) in
            onCompleted(moviesResponseObservable)
        }
    }
    
    func getLatestMovies(limit:Int,pageNo:Int,onCompleted:@escaping MoviesResponseBlock){
        let url = URL(string: String(format: URLConstants.Api.Path.getLatestMovies, limit.description,pageNo.description).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        getMoviesResponse(for: url!) { (moviesResponseObservable) in
            onCompleted(moviesResponseObservable)
        }
    }
    
    func getPopularMovies(limit:Int,pageNo:Int,onCompleted:@escaping MoviesResponseBlock){
        let url = URL(string: String(format: URLConstants.Api.Path.getPopularMovies, limit.description,pageNo.description).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        getMoviesResponse(for: url!) { (moviesResponseObservable) in
            onCompleted(moviesResponseObservable)
        }
    }
    
    func getMovieDetails(for movieID:String,onCompleted:@escaping MovieDetailsResponseBlock){
        let url = URL(string: String(format: URLConstants.Api.Path.getMovieDetails, movieID).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        networkLayer.getResponseJSON(for: url!) { (dataObservable) in
            dataObservable.subscribe(onNext: { (data,error) in
                if let responseData = data{
                    self.translationLayer.getMovieDetails(from: responseData) { (movieResponseObservable) in
                        movieResponseObservable.subscribe(onNext: { (movieResponse,error) in
                            if let movieDetails = movieResponse{
                                onCompleted(Observable.just((movieDetails,nil)))
                            }else{
                                onCompleted(Observable.just((nil,error!)))
                            }
                        }).disposed(by: self.bag)
                    }
                }else{
                    onCompleted(Observable.just((nil,error!)))
                }
            }).disposed(by: self.bag)
        }
    }
    
    func searchMovies(for query:String,quality:String,genre:String,rating:String,orderBy:String,pageNo:Int,limit:Int,onCompleted:@escaping MoviesResponseBlock){
        let url = URL(string: String(format: URLConstants.Api.Path.searchMovies, query,quality,genre,rating,orderBy,pageNo.description,limit.description).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        getMoviesResponse(for: url!) { (moviesResponseObservable) in
            onCompleted(moviesResponseObservable)
        }
    }
    
    private func getMoviesResponse(for url:URL, onCompleted:@escaping (_ observale:Observable<(MoviesResponse?,Error?)>)->Void){
        networkLayer.getResponseJSON(for: url) { dataObservable in
            dataObservable.subscribe(onNext: { (data,error) in
                if let responseData = data{
                    self.translationLayer.getMovies(from: responseData) { (moviesResponeObservable) in
                        moviesResponeObservable.subscribe(onNext: { moviesResponse,error in
                            if let movies = moviesResponse{
                                onCompleted(Observable.just((movies,nil)))
                            }else{
                                onCompleted(Observable.just((nil,error!)))
                            }
                        }).disposed(by: self.bag)
                    }
                }else{
                    onCompleted(Observable.just((nil,error!)))
                }
            }).disposed(by: self.bag)
        }
    }
}

