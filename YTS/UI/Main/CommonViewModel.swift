//
//  CommonViewModel.swift
//  YTS
//
//  Created by Sajith Konara on 5/2/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
class CommonViewModel{
    
    fileprivate var modelLayer:ModelLayerIMPL
    
    init(modelLayer:ModelLayerIMPL) {
        self.modelLayer = modelLayer
    }
    
    
    func loadMostRatedMovies(limit:Int = 10,pageNo:Int = 1,onCompleted:@escaping (_ moviesData:DataClass)->Void){
           modelLayer.getMostRatedMovies(limit: limit, pageNo: pageNo) { moviesResponse in
            onCompleted(moviesResponse.data)
           }
       }
       
       
       func loadPopularMovies(limit:Int = 10,pageNo:Int = 1,onCompleted:@escaping (_ moviesData:DataClass)->Void){
           modelLayer.getPopularMovies(limit: limit, pageNo: pageNo) { moviesResponse in
               onCompleted(moviesResponse.data)
           }
       }
    
    func loadLatestMovies(limit:Int = 10,pageNo:Int = 1,onCompleted:@escaping(_ moviesData:DataClass)->Void){
           modelLayer.getLatestMovies(limit: limit, pageNo: pageNo) { moviesResponse  in
               onCompleted(moviesResponse.data)
           }
       }
    
}
