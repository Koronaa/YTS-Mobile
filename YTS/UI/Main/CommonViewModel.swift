//
//  CommonViewModel.swift
//  YTS
//
//  Created by Sajith Konara on 5/2/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import RxSwift

class CommonViewModel{
    
    fileprivate var bag = DisposeBag()
    fileprivate var modelLayer:ModelLayerIMPL
    
    init(modelLayer:ModelLayerIMPL) {
        self.modelLayer = modelLayer
    }
    
    
    func loadMostRatedMovies(limit:Int = 10,pageNo:Int = 1,onCompleted:@escaping (_ dataObservable:Observable<(DataClass?,Error?)>)->Void){
        modelLayer.getMostRatedMovies(limit: limit, pageNo: pageNo) { (movieResponseObservable) in
            movieResponseObservable.subscribe(onNext: { (movieResponse,error) in
                onCompleted(Observable.just((movieResponse?.data,error)))
            }).disposed(by: self.bag)
        }
    }
    
    
    func loadPopularMovies(limit:Int = 10,pageNo:Int = 1,onCompleted:@escaping (_ dataObservable:Observable<(DataClass?,Error?)>)->Void){
        modelLayer.getPopularMovies(limit: limit, pageNo: pageNo) { (movieResponseObservable) in
            movieResponseObservable.subscribe(onNext: { (movieResponse,error) in
                onCompleted(Observable.just((movieResponse?.data,error)))
            }).disposed(by: self.bag)
        }
    }
    
    func loadLatestMovies(limit:Int = 10,pageNo:Int = 1,onCompleted:@escaping (_ dataObservable:Observable<(DataClass?,Error?)>)->Void){
        modelLayer.getLatestMovies(limit: limit, pageNo: pageNo) { (movieResponseObservable) in
            movieResponseObservable.subscribe(onNext: { (movieResponse,error) in
                onCompleted(Observable.just((movieResponse?.data,error)))
            }).disposed(by: self.bag)
        }
    }
}
