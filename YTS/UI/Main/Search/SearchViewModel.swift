//
//  SearchViewModel.swift
//  YTS
//
//  Created by Sajith Konara on 4/27/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

class SearchViewModel{
    
    fileprivate let modelLayer:ModelLayerIMPL
    
    init(modelLayer:ModelLayerIMPL) {
        self.modelLayer = modelLayer
    }
    
//    var searchedMovies:[Movie] = []
//    var searchedData:ResultData!
    
    var selectedGenre:String = ""
    var selectedQuality:String = ""
    var selectedRating:String = ""
    var selectedOrderBy:String = "Latest"
    var queryString:String = ""
    var selectedFilterCategory:FilterType = .Quality
    
    var currenFilter:[Filter] = []
    var genreFilter:[Filter] = Filter.generateFilter(for: .Genre)
    var qualityFilter:[Filter] = Filter.generateFilter(for: .Quality)
    var ratingFilter:[Filter]  = Filter.generateFilter(for: .Rating)
    var orderByFilter:[Filter]  = Filter.generateFilter(for: .OrderBy)
    
    func selectedFilterValue(for row:Int, in filer:FilterType){
        switch filer {
        case .Genre:
            selectedGenre = row == 0 ? "" : genreFilter[row].name
        case .OrderBy:
            selectedOrderBy = orderByFilter[row].name
        case .Quality:
            selectedQuality = row == 0 ? "" : qualityFilter[row].name
        case .Rating:
            var selectedRatingValue:String = row == 0 ? "" : ratingFilter[row].name
            selectedRating = selectedRatingValue.removeFirst().description
        }
    }
    
    func resetFilters(){
        genreFilter = Filter.generateFilter(for: .Genre)
        qualityFilter = Filter.generateFilter(for: .Quality)
        ratingFilter  = Filter.generateFilter(for: .Rating)
        orderByFilter = Filter.generateFilter(for: .OrderBy)
        selectedGenre = ""
        selectedQuality = ""
        selectedRating = ""
        selectedOrderBy = "Latest"
    }
    
    
    func search(pageNo:Int = 1,limit:Int = 10,onCompleted:@escaping (_ movieData:DataClass)->Void){
        modelLayer.searchMovies(for: queryString, quality: selectedQuality, genre: selectedGenre, rating: selectedRating, orderBy: selectedOrderBy,pageNo: pageNo,limit: limit) { moviesResponse in
//            self.searchedMovies = moviesResponse.data.movies ?? [Movie]()
//            self.searchedData = ResultData(limit: moviesResponse.data.limit, pageNo: moviesResponse.data.pageNumber, movieCount: moviesResponse.data.movieCount)
            onCompleted(moviesResponse.data)
        }
    }
}
