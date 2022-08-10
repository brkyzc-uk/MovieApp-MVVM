//
//  CastDetailModel.swift
//  MovieApp-MVVM
//
//  Created by Burak YAZICI on 10/08/2022.
//

import Foundation

struct  CastDetailModel: Decodable {
    
    let name: String?
    let character: String?
    let knownForDepartment: String?
    let profilePath: String?
    let gender: Int?
    let popularity: Double?
    
    enum CodingKeys: String, CodingKey {
        case name, character, gender, popularity
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
    
    }
}
