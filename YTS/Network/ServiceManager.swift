//
//  ServiceManager.swift
//  YTS
//
//  Created by Sajith Konara on 4/25/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias onAPIResponse = (_ response:JSON?, _ statusCode:Int)->()

class ServiceManager{
    static func APIRequest(url:URL,method:HTTPMethod,params:Parameters? = nil,onResponse:onAPIResponse?){
    
        if ReachabilityManager.isConnectedToNetwork(){
            AF.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: nil, interceptor: nil).responseJSON { response in
                if let statusCode = response.response?.statusCode {
                    let jsonResponse =  JSON(response.data)
                    onResponse!(jsonResponse,statusCode)
                }
            }
        }else{
            onResponse!(nil,999)
        }
        
    
    }
}

