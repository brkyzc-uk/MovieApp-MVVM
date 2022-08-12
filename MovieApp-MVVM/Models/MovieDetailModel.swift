//
//  MovieDetailModel.swift
//  MovieApp-MVVM
//
//  Created by Burak YAZICI on 10/08/2022.
//

import Foundation

struct MovieDetail: Decodable {
    
    let id: Int?
    let name: String?
    let posterPath: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}


struct MovieCredits: Decodable {
    
    let id: Int?
    let cast: [CastDetailModel]
    
    enum CodingKeys: String, CodingKey {
        case id, cast
    }
}

class CastModel {
    
    var name: String?
    var imagePath: String?
    var character: String?
    init(name: String?, imagePath: String?, character: String?) {
        self.name = name
        self.imagePath = imagePath
        self.character = character
    }
}
