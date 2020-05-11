//
//  MovieServiceLayer.swift
//  YTS
//
//  Created by Sajith Konara on 4/27/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkLayer {
    typealias DataObservable = (_ observable:Observable<(data:Data?,error:Error?)>)->Void
    func getResponseJSON(for url:URL,onCompleted:@escaping DataObservable)
}

class NetworkLayerIMPL:NetworkLayer{
    
    fileprivate let bag = DisposeBag()
    
    func getResponseJSON(for url: URL, onCompleted: @escaping (Observable<(data: Data?, error: Error?)>) -> Void) {
        ServiceManagerIMPL.APIRequest(url: url, method: .get) { responseObservable in
            responseObservable.subscribe(onNext: { responseData,responseCode in
                if responseCode == 200{
                    onCompleted(Observable.just((responseData!,nil)))
                }else if responseCode == 999{
                    let error = Error(title: "No Connectivity!", message: "You are appear to be offline.")
                    onCompleted(Observable.just((nil,error)))
                }else{
                    let error = Error(title: "Data Error!", message: "Something went wrong while retrieving data.")
                    onCompleted(Observable.just((nil,error)))
                }
            }).disposed(by: self.bag)
        }
    }
}
