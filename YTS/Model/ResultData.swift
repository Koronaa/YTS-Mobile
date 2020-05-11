//
//  File.swift
//  YTS
//
//  Created by Sajith Konara on 4/30/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

class ResultData{
    var limit:Int
    var pageNo:Int
    var movieCount:Int
    
    init(limit:Int,pageNo:Int,movieCount:Int){
        self.limit = limit
        self.pageNo = pageNo
        self.movieCount = movieCount
    }
}
