//
//  TranslationLayer.swift
//  YTS
//
//  Created by Sajith Konara on 4/25/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import SwiftyJSON

class TranslationLayer{
    
    func getMovies(from json:JSON) -> [Movie]{
        var receivedMovies:[Movie] = []
        var receivedTorrents:[Torrent]
        if let data = json["data"].dictionary{
            if let movies = data["movies"]?.array{
                for movie in movies{
                    receivedTorrents = []
                    if let title = movie["title"].string,
                        let id = movie["id"].int,
                        let year = movie["year"].int,
                        let genre = movie["genres"].arrayObject as? [String],
                        let rating = movie["rating"].double,
                        let lang = movie["language"].string,
                        let mpaRating = movie["mpa_rating"].string,
                        let duration = movie["runtime"].int,
                        let trailerCode = movie["yt_trailer_code"].string,
                        let pageURLString = movie["url"].string,
                        let description = movie["synopsis"].string,
                        let imageURLString = movie["large_cover_image"].string,
                        let torrents = movie["torrents"].array {
                        for torrent in torrents{
                            if let downloadURLString = torrent["url"].string,
                                let quality = torrent["quality"].string,
                                let type = torrent["type"].string,
                                let size = torrent["size"].string{
                                let torrent = Torrent(downloadURL:  URL(string: downloadURLString)! , quality: quality, type: type, size: size, posterURL: URL(string: imageURLString)!)
                                receivedTorrents.append(torrent)
                            }
                        }
                        let movie = Movie(title: title, id: id, year: year, genre: genre.joined(separator: " / "), rating: rating, language: lang, mpaRating: mpaRating, duration: duration, youtubeTrailerCode: trailerCode, ytsPageURL: URL(string: pageURLString)!, description: description, imageURL: URL(string: imageURLString)!, torrents: receivedTorrents, cast: nil)
                        receivedMovies.append(movie)
                    }
                }
            }
        }
        return receivedMovies
    }
    
    func  getCastDetails(from json:JSON) -> [Cast]{
        var castDetails:[Cast] = []
        if let movieData = json["data"].dictionary{
            if let movie = movieData["movie"]?.dictionary{
                if let casts = movie["cast"]?.array{
                    for cast in casts{
                        if let name = cast["name"].string,
                            let url = cast["url_small_image"].string{
                            let cast = Cast(name: name, imageURL: URL(string: url)!)
                            castDetails.append(cast)
                        }
                    }
                }
            }
        }
        return castDetails
    }
    
    
}
