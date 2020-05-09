//
//  Movie.swift
//  YTS
//
//  Created by Sajith Konara on 4/25/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

struct Movie:Decodable {
    var title:String
    var id:Int
    var year:Int
    var genres:[String]
    var rating:Double
    var language:String
    var mpaRating:String
    var duration:Int
    var youtubeTrailerCode:String?
    var ytsPageURL:String
    var description:String
    var imageURL:String
    var torrents:[Torrent]?
    var cast:[Cast]?
    
    enum CodingKeys:String,CodingKey{
        case title
        case id
        case year
        case genres
        case rating
        case language
        case mpaRating = "mpa_rating"
        case duration = "runtime"
        case youtubeTrailerCode = "yt_trailer_code"
        case ytsPageURL = "url"
        case description = "description_full"
        case imageURL = "large_cover_image"
        case torrents
        case cast
        
    }
}
