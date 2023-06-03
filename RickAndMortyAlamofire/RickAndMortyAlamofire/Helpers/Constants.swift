//
//  Constants.swift
//  RickAndMortyAlamofire
//
//  Created by Serdar Onur KARADAĞ on 1.06.2023.
//

import Foundation

class Constants {
    static var baseURL: String {
        return "https://rickandmortyapi.com/api/character/"
    }
    
    static func characterURL(forPage page: Int) -> URL? {
        var urlComponents = URLComponents(string: baseURL)
        let pageQueryItem = URLQueryItem(name: "page", value: "\(page)")
        urlComponents?.queryItems = [pageQueryItem]
        return urlComponents?.url
    }
}
