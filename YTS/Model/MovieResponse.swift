//
//  MovieResponse.swift
//  YTS
//
//  Created by Sajith Konara on 5/8/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

struct MovieResponse: Decodable {
    let data: MovieDataClass
}

struct MovieDataClass: Decodable {
    let movie: Movie
}
