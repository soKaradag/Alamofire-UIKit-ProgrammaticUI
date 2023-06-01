//
//  CharacterModel.swift
//  RickAndMortyAlamofire
//
//  Created by Serdar Onur KARADAĞ on 1.06.2023.
//

import Foundation

struct PersonResponse: Codable {
    let results: [Person]
}

struct Person: Codable {
    var id: Int
    var name: String
    var status: String
    var gender: String
    var image: String
}

