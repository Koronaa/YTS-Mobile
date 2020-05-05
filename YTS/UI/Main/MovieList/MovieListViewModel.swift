//
//  MovieListViewModel.swift
//  YTS
//
//  Created by Sajith Konara on 4/27/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
class MovieListViewModel{
    
    
    fileprivate var commonViewModel:CommonViewModel?
    var searchViewModel:SearchViewModel!
    var movieListType:MovieListType
    
    init(commonViewModel:CommonViewModel?,movieListType:MovieListType) {
        self.commonViewModel = commonViewModel
        self.movieListType = movieListType
    }
    
    var movies:[Movie] = []
    var data:Data?
    
    var limit:Int {data?.limit ?? 0}
    var totalNoOfPages:Int { return (data?.movieCount) ?? 0/limit}
    var currentPage:Int {return data?.pageNo ?? 0}
    var totalMovies:Int {return movies.count}
    
    func addMovies(movies:[Movie],data:Data){
        if self.movies.count == 0{
            self.movies = movies
            self.data = data
        }else{
            self.movies += movies
        }
    }
    
    
    func loadData(onCompleted:@escaping()->Void){
        switch movieListType {
        case .LATEST:
            commonViewModel!.loadLatestMovies(limit: 50, pageNo: currentPage) { (movies, data) in
                self.addMovies(movies: movies, data: data)
                onCompleted()
            }
        case .POPULAR:
            commonViewModel!.loadPopularMovies(limit: 50, pageNo: currentPage){ (movies, data) in
                self.addMovies(movies: movies, data: data)
                onCompleted()
            }
        case .RATED:
            commonViewModel!.loadMostRatedMovies(limit: 50, pageNo: currentPage){ (movies, data) in
                self.addMovies(movies: movies, data: data)
                onCompleted()
            }
        case .SEARCH:
            searchViewModel!.search(pageNo: currentPage, limit: 50) {
                self.addMovies(movies: self.searchViewModel!.searchedMovies, data: self.searchViewModel!.searchedData)
                onCompleted()
            }
            
        }
    }
    
}


