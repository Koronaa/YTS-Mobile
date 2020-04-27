//
//  MovieServiceLayer.swift
//  YTS
//
//  Created by Sajith Konara on 4/27/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
import SwiftyJSON

class NetworkLayer{
    
    func getMoviesJSON(for url:URL,onCompleted: @escaping (_ response:JSON)->Void){
        ServiceManager.APIRequest(url: url, method: .get) { (responseJSON, responseCode) in
            if responseCode == 200{
                onCompleted(responseJSON!)
            }else{
                //ERROR
            }
        }
    }
}
