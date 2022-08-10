//
//  HomeMovieModel.swift
//  MovieApp-MVVM
//
//  Created by Burak YAZICI on 08/08/2022.
//

import Foundation

struct HomeMovies: Decodable {
    let page: Int
    let results: [MovieResults]
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
    }
}

struct MovieResults: Decodable {
    
    let id: Int?
    let title: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    let popularity: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}

public class MovieModel {
    var title: String?
    var imageUrl: String?
    var releaseDate: String?
    var voteAverage: Double?
    
    public init(title: String?, imageUrl: String?, releaseDate: String?, voteAverage: Double?) {
        self.title = title
        self.imageUrl = imageUrl
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
    }
}
