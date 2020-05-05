//
//  CommonViewModel.swift
//  YTS
//
//  Created by Sajith Konara on 5/2/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
class CommonViewModel{
    
    fileprivate var modelLayer:ModelLayer
    
    init(modelLayer:ModelLayer) {
        self.modelLayer = modelLayer
    }
    
    
    func loadMostRatedMovies(limit:Int = 10,pageNo:Int = 1,onCompleted:@escaping (_ movies:[Movie],_ data:Data)->Void){
           modelLayer.getMostRatedMovies(limit: limit, pageNo: pageNo) { movies,data in
               onCompleted(movies,data)
           }
       }
       
       
       func loadPopularMovies(limit:Int = 10,pageNo:Int = 1,onCompleted:@escaping (_ movies:[Movie],_ data:Data)->Void){
           modelLayer.getPopularMovies(limit: limit, pageNo: pageNo) { movies,data in
               onCompleted(movies,data)
           }
       }
    
    func loadLatestMovies(limit:Int = 10,pageNo:Int = 1,onCompleted:@escaping(_ movies:[Movie],_ data:Data)->Void){
           modelLayer.getLatestMovies(limit: limit, pageNo: pageNo) { latestMovies,data  in
               onCompleted(latestMovies,data)
           }
       }
    
}
