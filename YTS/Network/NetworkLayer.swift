//
//  MovieServiceLayer.swift
//  YTS
//
//  Created by Sajith Konara on 4/27/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

protocol NetworkLayer {
    func getResponseJSON(for url:URL,onCompleted: @escaping (_ responseData:Data)->Void)
}

class NetworkLayerIMPL:NetworkLayer{
    
    func getResponseJSON(for url:URL,onCompleted: @escaping (_ responseData:Data)->Void){
        ServiceManagerIMPL.APIRequest(url: url, method: .get) { (responseData, responseCode) in
            if responseCode == 200{
                onCompleted(responseData!)
            }else{
                //TODO: ERROR
            }
        }
    }
}
