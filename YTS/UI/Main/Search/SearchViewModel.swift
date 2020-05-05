//
//  SearchViewModel.swift
//  YTS
//
//  Created by Sajith Konara on 4/27/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

class SearchViewModel{
    
    fileprivate let modelLayer:ModelLayer
    
    init(modelLayer:ModelLayer) {
        self.modelLayer = modelLayer
    }
    
    var searchedMovies:[Movie] = []
    var searchedData:Data!
    
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
    
    
    func search(pageNo:Int = 1,limit:Int = 50,onCompleted:@escaping ()->Void){
        modelLayer.searchMovies(for: queryString, quality: selectedQuality, genre: selectedGenre, rating: selectedRating, orderBy: selectedOrderBy,pageNo: pageNo,limit: limit) { movies,data in
            self.searchedMovies = movies
            self.searchedData = data
            onCompleted()
        }
    }
}
