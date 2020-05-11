//
//  TranslationLayer.swift
//  YTS
//
//  Created by Sajith Konara on 4/25/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import RxSwift

class TranslationLayer{
    
    func getMovies(from responseData:Data,onCompleted: @escaping (_ observable:Observable<(moviesReponse:MoviesResponse?,error:Error?)>)->Void){
        let decorder = JSONDecoder()
        do{
            let moviesResponse = try decorder.decode(MoviesResponse.self, from: responseData)
            onCompleted(Observable.just((moviesResponse,nil)))
        }catch(let e){
            let error = Error(title: "Translation Error!", message: "Something went wrong while translating data.")
            onCompleted(Observable.just((nil,error)))
            print(e)
            
        }
    }
    
    func getMovieDetails(from responseData:Data,onCompleted: @escaping (_ observable:Observable<(movieResponse:MovieResponse?,error:Error?)>)->Void){
        let decorder = JSONDecoder()
        do{
            let movieResponse = try decorder.decode(MovieResponse.self, from: responseData)
            onCompleted(Observable.just((movieResponse,nil)))
        }catch(let e){
            let error = Error(title: "Translation Error!", message: "Something went wrong while translating data.")
            onCompleted(Observable.just((nil,error)))
            print(e)
        }
    }
}
