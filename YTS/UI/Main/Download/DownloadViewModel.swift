//
//  DownloadViewModel.swift
//  YTS
//
//  Created by Sajith Konara on 4/29/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
class DownloadViewModel{
    
    var movie:Movie
    
    init(movie:Movie) {
        self.movie = movie
    }
    
    var torrents:[Torrent] {
        return movie.torrents ?? [Torrent]()
    }
}
