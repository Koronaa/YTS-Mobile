//
//  FavouriteCellViewModel.swift
//  YTS
//
//  Created by Sajith Konara on 4/27/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

class FavouriteCellViewModel {
    var movie:Movie
    
    init(movie:Movie) {
        self.movie = movie
    }
    
    var movieImageURL:URL {return movie.imageURL}
    
}
