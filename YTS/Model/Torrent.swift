//
//  Torrent.swift
//  YTS
//
//  Created by Sajith Konara on 4/25/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

struct Torrent:Decodable {
    var downloadURL:String
    var quality:String
    var type:String
    var size:String
    
    
    enum CodingKeys:String,CodingKey{
        case downloadURL = "url"
        case quality
        case type
        case size
    }
}

