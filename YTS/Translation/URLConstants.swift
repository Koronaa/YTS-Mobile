//
//  URLConstants.swift
//  YTS
//
//  Created by Sajith Konara on 4/25/20.
//  Copyright © 2020 Sajith Konara. All rights reserved.
//

import Foundation

struct URLConstants {
    
    struct Api {
        static let HOST = "https://yts.mx/api/v2"
        
        struct Path {
            
            static var getPopularMovies:String{
                return HOST + "/list_movies.json?sort_by=download_count&limit=%@&page=%@"
            }
            
            static var getMovieDetails:String{
                return HOST + "/movie_details.json?movie_id=%@&with_images=true&with_cast=true"
            }
            
            static var getMostRatedMovies:String{
                return HOST + "/list_movies.json?sort_by=rating&limit=%@&page=%@"
            }
            
            static var getLatestMovies:String{
                return HOST + "/list_movies.json?sort_by=year&limit=%@&page=%@"
            }
            
            static var searchMovies:String{
                return HOST + "/list_movies.json?query_term=%@&quality=%@&genre=%@&minimum_rating=%@&sort_by=%@&page=%@&limit=%@"
            }
        }
    }
}
