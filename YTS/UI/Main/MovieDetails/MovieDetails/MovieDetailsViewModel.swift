//
//  MovieDetailsViewModel.swift
//  YTS
//
//  Created by Sajith Konara on 4/27/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
class MovieDetailsViewModel{
    
    var movie:Movie
    fileprivate var modelLayer:ModelLayerIMPL
    
    init(modelLayer:ModelLayerIMPL,movie:Movie) {
        self.modelLayer = modelLayer
        self.movie = movie
    }
    
    var imageURL:URL? {return URL(string: movie.imageURL)}
    
    var title:String {return movie.title}
    
    var pageURL:URL? {return URL(string: movie.ytsPageURL)}
    
    var rating:Double {return movie.rating}
    
    var youtubeLinkCode:String? {
        if movie.youtubeTrailerCode == ""{
            return nil
        }else{
            return movie.youtubeTrailerCode
        }
    }
    
    var year:String {return movie.year.description}
    
    var genre:String {return movie.genres.joined(separator: " / ") }
    
    private  var durationString:String {
        if movie.duration != 0{
            let durationHours = (movie.duration/60)
            let durationMin = movie.duration % 60
            return "\(durationHours) hr \(durationMin) min"
        }else{
            return "N/A"
        }
    }
    
    var trailerURL:URL?{
        if let trailerCode = youtubeLinkCode{
            let urlString = "https://www.youtube.com/watch?v=\(String(describing: trailerCode))"
            return URL(string: urlString)
        }else{
            return nil
        }
    }
    
    var shortDescription:String {return "\(movie.language) | \(movie.mpaRating == ""  ? "N/A" : movie.mpaRating ) | \(durationString)"}
    
    var availableIn:String {
        var mixArray:[String] = []
        if let torrents = movie.torrents{
            let types:[String] = torrents.map { return $0.type}
            let qualities:[String] = torrents.map {return $0.quality}
            for (index,type) in types.enumerated(){
                mixArray.append("\(type).\(qualities[index])")
            }
            return mixArray.joined(separator: " , ")
        }
        return "Torrent info not available."
    }
    
    var synopsis:String {return movie.description}
    
    var cast:[Cast] = []
    
    func getCast(onCompleted:@escaping ()-> Void){
        modelLayer.getMovieDetails(for: movie.id.description) { movieResponse in
            if let cast = movieResponse.data.movie.cast{
                self.cast = cast
            }
            onCompleted()
        }
    }
    
}
