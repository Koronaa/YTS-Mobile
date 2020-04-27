//
//  SearchViewModel.swift
//  YTS
//
//  Created by Sajith Konara on 4/27/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

class SearchViewModel{
    
    var selectedGenre:String = ""
    var selectedQuality:String = ""
    var selectedRating:String = ""
    var selectedOrderBy:String = "Latest"
    
    var selectedFilterCategory:FilterType = .Quality
    
    let modelLayer:ModelLayer = ModelLayer()
    
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
            print(selectedRating)
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
    
    
    
    func search(for query:String,onCompleted:@escaping (_ movies:[Movie])->Void){
        modelLayer.searchMovies(for: query, quality: self.selectedQuality, genre: self.selectedGenre, rating: self.selectedRating, orderBy: selectedOrderBy) { movies in
            onCompleted(movies)
        }
    }
    
    
}
