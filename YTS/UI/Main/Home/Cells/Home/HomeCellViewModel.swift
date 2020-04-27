//
//  HomeCellViewModel.swift
//  YTS
//
//  Created by Sajith Konara on 4/27/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

class HomeCellViewModel{
    
    let movie:Movie!
    
    init(movie:Movie) {
        self.movie = movie
    }
    
    var imageURL:URL {return movie.imageURL}
    var title:String {return movie.title}
    var year:String {return movie.year.description}
    var duration:String {return movie.durationString}
    var rating:String {return "IMDB: \(movie.rating)/10"}
}
