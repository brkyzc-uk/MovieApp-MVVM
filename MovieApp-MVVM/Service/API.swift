//
//  API.swift
//  MovieApp-MVVM
//
//  Created by Burak YAZICI on 08/08/2022.
//

import Foundation

enum API: String {
    case movieBaseUrl = "https://api.themoviedb.org/3/movie/"
    case movieResultUrl  = "popular?api_key=f506ec91a7f3deb9dcc4d3a6243eb20d"
    case movieImageUrl = "https://image.tmdb.org/t/p/original"
    case movieCreditsUrl = "/credits?api_key=f506ec91a7f3deb9dcc4d3a6243eb20d"
}

class APIUrl {
    static let shared = APIUrl()
    
    private init() {
        
    }
    
    func getHomeMovieListUrl() -> String {
        return API.movieBaseUrl.rawValue + API.movieResultUrl.rawValue
    }
    
    func getMovieDetailUrl(with movieId: Int) -> String {
        return "\(API.movieBaseUrl.rawValue)\(movieId)\(API.movieCreditsUrl.rawValue)"
    }
}
