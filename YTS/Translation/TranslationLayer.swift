//
//  TranslationLayer.swift
//  YTS
//
//  Created by Sajith Konara on 4/25/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

class TranslationLayer{
    
    func getMovies(from responseData:Data,onCompleted: @escaping (_ moviesReponse:MoviesResponse)->Void){
        let decorder = JSONDecoder()
        do{
            let moviesResponse = try decorder.decode(MoviesResponse.self, from: responseData)
            onCompleted(moviesResponse)
        }catch{
            print(error)
        }
    }
    
    func getMovieDetails(from responseData:Data,onCompleted: @escaping (_ movieResponse:MovieResponse)->Void){
        let decorder = JSONDecoder()
        do{
            let movieResponse = try decorder.decode(MovieResponse.self, from: responseData)
            onCompleted(movieResponse)
        }catch{
            print(error)
        }
    }
}
