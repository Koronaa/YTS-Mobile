//
//  CastCellViewModel.swift
//  YTS
//
//  Created by Sajith Konara on 4/27/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
class CastCellViewModel {
    
    var cast:Cast
    
    init(cast:Cast) {
        self.cast = cast
    }
    
    var imageURL:URL? {return URL(string: cast.imageURL ?? "")}
    var name:String {return cast.name}

}
