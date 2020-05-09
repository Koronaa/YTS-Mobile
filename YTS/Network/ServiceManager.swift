//
//  ServiceManager.swift
//  YTS
//
//  Created by Sajith Konara on 4/25/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import Alamofire

typealias onAPIResponse = (_ response:Data?, _ statusCode:Int)->()

protocol ServiceManager {
    static func APIRequest(url:URL,method:HTTPMethod,params:Parameters?,onResponse:onAPIResponse?)
}

class ServiceManagerIMPL:ServiceManager{
    static func APIRequest(url:URL,method:HTTPMethod,params:Parameters? = nil,onResponse:onAPIResponse?){
        
        if ReachabilityManager.isConnectedToNetwork(){
            AF.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { response in
                if let statusCode = response.response?.statusCode {
                    if let data = response.data{
                        onResponse!(data,statusCode)
                    }else{
                        //TODO
                    }
                }
            }
        }else{
            onResponse!(nil,999)
        }
        
        
    }
}

