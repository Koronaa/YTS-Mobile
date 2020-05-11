//
//  ServiceManager.swift
//  YTS
//
//  Created by Sajith Konara on 4/25/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

protocol ServiceManager {
    typealias onAPIRxResponse = (_ observable:Observable<(Data?,Int)>)->()
    static func APIRequest(url:URL,method:HTTPMethod,params:Parameters?,onResponse:@escaping onAPIRxResponse)
}

class ServiceManagerIMPL:ServiceManager{
    static func APIRequest(url:URL,method:HTTPMethod,params:Parameters? = nil,onResponse: @escaping onAPIRxResponse){
        
        if ReachabilityManager.isConnectedToNetwork(){
            AF.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { response in
                if let statusCode = response.response?.statusCode {
                    onResponse(Observable.just((response.data,statusCode)))
                }
            }
        }else{
            onResponse(Observable.just((nil,999)))
        }
    }
}

