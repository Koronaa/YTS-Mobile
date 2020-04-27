//
//  Movie.swift
//  YTS
//
//  Created by Sajith Konara on 4/25/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

struct Movie {
    var title:String
    var id:Int
    var year:Int
    var genre:String
    var rating:Double
    var language:String
    var mpaRating:String
    var duration:Int
    var youtubeTrailerCode:String?
    var ytsPageURL:URL
    var description:String
    var imageURL:URL
    var torrents:[Torrent]
    var cast:[Cast]?
    
    
    var durationString:String {
        let durationHours = (self.duration/60)
        let durationMin = self.duration % 60
        return "\(durationHours) hr \(durationMin) min"
    }
    
    var trailerURL:URL?{
        let urlString = "https://www.youtube.com/watch?v=\(String(describing: self.youtubeTrailerCode))"
        return URL(string: urlString)
    }
}
