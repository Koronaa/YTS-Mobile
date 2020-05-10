//
//  HomeViewModel.swift
//  YTS
//
//  Created by Sajith Konara on 4/27/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel{
    
    var latestMovies:[Movie] = []
    var latestMovieData:ResultData!
    var topRatedMovies:[Movie] = []
    var topRatedMoviesData:ResultData!
    var popularMovies: [Movie] = []
    var popularMoviesData:ResultData!
    
    fileprivate var commonViewModel:CommonViewModel
    fileprivate let bag = DisposeBag()
    
    init(commonViewModel:CommonViewModel) {
        self.commonViewModel = commonViewModel
    }
    
    func loadLatestMovies(onCompleted:@escaping(Observable<Error?>)->Void){
        
        commonViewModel.loadLatestMovies { (movieDataObservable) in
            movieDataObservable.subscribe(onNext: { moviesData,error in
                if let moviesInfo = moviesData{
                    self.latestMovies = moviesInfo.movies!
                    self.latestMovieData = ResultData(limit: moviesInfo.limit, pageNo: moviesInfo.pageNumber, movieCount: moviesInfo.movieCount)
                    onCompleted(Observable.just(nil))
                }else{
                    onCompleted(Observable.just(error!))
                }
            }).disposed(by: self.bag)
        }
    }
    
    func loadPopularMovies(onCompleted:@escaping(Observable<Error?>)->Void){
        
        commonViewModel.loadPopularMovies { (movieDataObservable) in
            movieDataObservable.subscribe(onNext: { (moviesData,error) in
                if let moviesInfo = moviesData{
                    self.popularMovies = moviesInfo.movies!
                    self.popularMoviesData = ResultData(limit: moviesInfo.limit, pageNo: moviesInfo.pageNumber, movieCount: moviesInfo.movieCount)
                    onCompleted(Observable.just(nil))
                }else{
                    onCompleted(Observable.just(error!))
                }
            }).disposed(by: self.bag)
        }
    }
    
    func loadTopRatedMovies(onCompleted:@escaping(Observable<Error?>)->Void){
        
        commonViewModel.loadMostRatedMovies{ (movieDataObservable) in
            movieDataObservable.subscribe(onNext: { (moviesData,error) in
                if let moviesInfo = moviesData{
                    self.topRatedMovies = moviesInfo.movies!
                    self.topRatedMoviesData = ResultData(limit: moviesInfo.limit, pageNo: moviesInfo.pageNumber, movieCount: moviesInfo.movieCount)
                    onCompleted(Observable.just(nil))
                }else{
                    onCompleted(Observable.just(error!))
                }
            }).disposed(by: self.bag)
        }
        
    }
}

