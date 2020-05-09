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
    
    
    func loadData(onCompleted:@escaping()->Void){
        switch movieListType {
        case .LATEST:
            commonViewModel!.loadLatestMovies(limit: 50, pageNo: currentPage) { moviesData in
                self.addMovies(moviesData: moviesData)
                onCompleted()
            }
        case .POPULAR:
            commonViewModel!.loadPopularMovies(limit: 50, pageNo: currentPage){ moviesData in
                self.addMovies(moviesData: moviesData)
                onCompleted()
            }
        case .RATED:
            commonViewModel!.loadMostRatedMovies(limit: 50, pageNo: currentPage){ moviesData in
                self.addMovies(moviesData: moviesData)
                onCompleted()
            }
        case .SEARCH:
            searchViewModel!.search(pageNo: currentPage, limit: 50) { moviesData in
                self.addMovies(moviesData: moviesData)
                onCompleted()
            }
            
        }
    }
    
}


