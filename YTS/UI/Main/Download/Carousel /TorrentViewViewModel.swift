//
//  TorrentViewViewModel.swift
//  YTS
//
//  Created by Sajith Konara on 4/29/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation
class TorrentViewViewModel{
    
    var torrent:Torrent
    var movie:Movie
    
    init(torrent:Torrent,movie:Movie) {
        self.torrent = torrent
        self.movie = movie
    }
    
    var posterURL:URL {
        return URL(string: movie.imageURL)!
    }
    
}
