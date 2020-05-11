//
//  MoviesResponse.swift
//  YTS
//
//  Created by Sajith Konara on 5/8/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation


struct MoviesResponse: Decodable {
    let data: DataClass
}

struct DataClass: Decodable {
    let movieCount, limit, pageNumber: Int
    let movies: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case movieCount = "movie_count"
        case limit
        case pageNumber = "page_number"
        case movies
    }
}


