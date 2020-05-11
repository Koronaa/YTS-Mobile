//
//  MovieListViewModel.swift
//  YTS
//
//  Created by Sajith Konara on 4/27/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import RxSwift

class MovieListViewModel{
    
    
    fileprivate var commonViewModel:CommonViewModel?
    fileprivate let bag = DisposeBag()
    
    var searchViewModel:SearchViewModel!
    var movieListType:MovieListType
    
    init(commonViewModel:CommonViewModel?,movieListType:MovieListType) {
        self.commonViewModel = commonViewModel
        self.movieListType = movieListType
    }
    
    var movies:[Movie] = []
    var data:ResultData?
    
    var limit:Int {data?.limit ?? 0}
    var totalNoOfPages:Int { return (data?.movieCount) ?? 0/limit}
    var currentPage:Int {return data?.pageNo ?? 0}
    var totalMovies:Int {return movies.count}
    
    func addMovies(moviesData:DataClass){
        if self.movies.count == 0{
            self.movies = moviesData.movies ?? [Movie]()
            self.data = ResultData(limit: moviesData.limit, pageNo: moviesData.pageNumber, movieCount: moviesData.movieCount)
        }else{
            self.movies += moviesData.movies ?? [Movie]()
        }
    }
    
    
    func loadData(onCompleted:@escaping(Observable<Error?>)->Void){
        switch movieListType {
        case .LATEST:
            commonViewModel!.loadLatestMovies(limit: 50, pageNo: currentPage) { (moviesDataObservable) in
                moviesDataObservable.subscribe(onNext: { moviesData,error in
                    if let data = moviesData{
                        self.addMovies(moviesData: data)
                        onCompleted(Observable.just(nil))
                    }else{
                        onCompleted(Observable.just(error))
                    }
                }).disposed(by: self.bag)
            }
        case .POPULAR:
            commonViewModel!.loadPopularMovies(limit: 50, pageNo: currentPage) { (moviesDataObservable) in
                moviesDataObservable.subscribe(onNext: { moviesData,error in
                    if let data = moviesData{
                        self.addMovies(moviesData: data)
                        onCompleted(Observable.just(nil))
                    }else{
                        onCompleted(Observable.just(error))
                    }
                }).disposed(by: self.bag)
            }
        case .RATED:
            commonViewModel!.loadMostRatedMovies(limit: 50, pageNo: currentPage) { (moviesDataObservable) in
                moviesDataObservable.subscribe(onNext: { moviesData,error in
                    if let data = moviesData{
                        self.addMovies(moviesData: data)
                        onCompleted(Observable.just(nil))
                    }else{
                        onCompleted(Observable.just(error))
                    }
                }).disposed(by: self.bag)
            }
        case .SEARCH:
            searchViewModel!.search(pageNo: currentPage, limit: 50){ (moviesDataObservable) in
                moviesDataObservable.subscribe(onNext: { moviesData,error in
                    if let data = moviesData{
                        self.addMovies(moviesData: data)
                        onCompleted(Observable.just(nil))
                    }else{
                        onCompleted(Observable.just(error))
                    }
                }).disposed(by: self.bag)
            }
        }
    }
    
}


