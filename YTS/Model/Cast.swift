//
//  Cast.swift
//  YTS
//
//  Created by Sajith Konara on 4/25/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

struct Cast:Decodable {
    var name:String
    var imageURL:String?
    
    
    enum CodingKeys:String,CodingKey{
        case name
        case imageURL = "url_small_image"
    }
}
