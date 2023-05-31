//
//  APIHandler.swift
//  RickAndMortyAlamofire
//
//  Created by Serdar Onur KARADAĞ on 1.06.2023.
//

import Foundation
import Alamofire

class APIHandler {
    func fetchData() {
        AF.request(Constants().baseURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
            if let data = response.data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                } catch  {
                    print("Error")
                }
            }
        }
    }
}

