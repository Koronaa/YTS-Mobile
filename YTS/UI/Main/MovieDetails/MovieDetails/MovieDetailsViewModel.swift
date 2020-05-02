//
//  MovieDetailsViewModel.swift
//  YTS
//
//  Created by Sajith Konara on 4/27/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
class MovieDetailsViewModel{
    
    fileprivate var modelLayer:ModelLayer = ModelLayer()
    var movie:Movie
    
    init(movie:Movie) {
        self.movie = movie
    }
    
    var imageURL:URL {return movie.imageURL}
    var title:String {return movie.title}
    var rating:Double {return movie.rating}
    var year:String {return movie.year.description}
    var genre:String {return movie.genre}
    var shortDescription:String {return "\(movie.language) | \(movie.mpaRating) | \(movie.durationString)"}
    var availableIn:String {
        var mixArray:[String] = []
        let types:[String] = movie.torrents.map { return $0.type}
        let qualities:[String] = movie.torrents.map {return $0.quality}
        for (index,type) in types.enumerated(){
            mixArray.append("\(type).\(qualities[index])")
        }
        return mixArray.joined(separator: " , ")
    }
    var synopsis:String {return movie.description}
    var cast:[Cast] = []
    
    func getCast(onCompleted:@escaping ()-> Void){
        modelLayer.getCastDetails(for: movie.id.description) { cast in
            self.cast = cast
            onCompleted()
        }
    }
    
}
