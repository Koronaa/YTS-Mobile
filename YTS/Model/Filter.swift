//
//  Filter.swift
//  YTS
//
//  Created by Sajith Konara on 4/17/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

enum FilterType{
    case Quality
    case Genre
    case Rating
    case OrderBy
}

class Filter:Equatable {
    
    
    var name:String
    var isSelected:Bool
    
    init(name:String,isSelected:Bool = false) {
        self.name = name
        self.isSelected = isSelected
    }
    
    
    static func == (lhs: Filter, rhs: Filter) -> Bool {
        return lhs.name == rhs.name
    }
    
    static func generateFilter(for type:FilterType) -> [Filter] {
        switch type {
        case .Quality:
            return [Filter(name: "All",isSelected: true),
                    Filter(name: "720p"),
                    Filter(name: "1080p"),
                    Filter(name: "2160p"),
                    Filter(name: "3D")]
        case .Rating:
            return [Filter(name: "All",isSelected: true),
                    Filter(name: "9"),
                    Filter(name: "8"),
                    Filter(name: "7"),
                    Filter(name: "6"),
                    Filter(name: "5"),
                    Filter(name: "4"),
                    Filter(name: "3"),
                    Filter(name: "2"),
                    Filter(name: "1")]
        case .Genre:
            return [Filter(name: "All",isSelected: true),
                    Filter(name: "Action"),
                    Filter(name: "Adventure"),
                    Filter(name: "Animation"),
                    Filter(name: "Biography"),
                    Filter(name: "Comedy"),
                    Filter(name: "Crime"),
                    Filter(name: "Documentary"),
                    Filter(name: "Drama"),
                    Filter(name: "Family"),
                    Filter(name: "Fantasy"),
                    Filter(name: "Film-Noir"),
                    Filter(name: "Game-Show"),
                    Filter(name: "History"),
                    Filter(name: "Horror"),
                    Filter(name: "Music"),
                    Filter(name: "Musical"),
                    Filter(name: "Mystery"),
                    Filter(name: "News"),
                    Filter(name: "Reality-TV"),
                    Filter(name: "Romance"),
                    Filter(name: "Sci-Fi"),
                    Filter(name: "Sport"),
                    Filter(name: "Talk-Show"),
                    Filter(name: "Thriller"),
                    Filter(name: "War"),
                    Filter(name: "Western")]
        case .OrderBy:
            return [Filter(name: "Latest",isSelected: true),
                    Filter(name: "Oldest"),
                    Filter(name: "Featured"),
                    Filter(name: "Seeds"),
                    Filter(name: "Peers"),
                    Filter(name: "Year"),
                    Filter(name: "Rating"),
                    Filter(name: "Likes"),
                    Filter(name: "Alphabetical"),
                    Filter(name: "Downloads"),]
        }
    }
}
