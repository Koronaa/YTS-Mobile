//
//  MovieListViewModel.swift
//  YTS
//
//  Created by Sajith Konara on 4/27/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
class MovieListViewModel{
    var movies:[Movie] = []
    var data:Data!
    
    var totalNoOfPages:Int { return data.movieCount/data.limit}
    var currentPage:Int {return data.pageNo}
    var totalMovies:Int {return movies.count}
    
    func addMovies(movies:[Movie]){
        if self.movies.count == 0{
            self.movies = movies
        }else{
            self.movies += movies
        }
    }
    
    
}


