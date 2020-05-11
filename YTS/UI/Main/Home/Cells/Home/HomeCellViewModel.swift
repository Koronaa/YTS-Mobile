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
    
    var imageURL:URL {return URL(string: movie.imageURL)!}
    var title:String {return movie.title}
    var year:String {return movie.year.description}
    var duration:String {
        if movie.duration != 0{
            let durationHours = (movie.duration/60)
            let durationMin = movie.duration % 60
            return "\(durationHours) hr \(durationMin) min"
        }else{
            return "N/A"
        }
        
    }
    
    
    var rating:String {return "IMDB: \(movie.rating)/10"}
}
