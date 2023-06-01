//
//  APIHandler.swift
//  RickAndMortyAlamofire
//
//  Created by Serdar Onur KARADAĞ on 1.06.2023.
//

import Foundation
import Alamofire

class APIHandler {
    func fetchData(completion: @escaping ([Person]?, Error?) -> Void) {
        AF.request(Constants.baseURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseData { response in
            if let data = response.data {
                do {
                    let jsonData = try JSONDecoder().decode(PersonResponse.self, from: data)
                    completion(jsonData.results, nil)
                } catch let error {
                    completion(nil, error)
                }
            } else if let error = response.error {
                completion(nil, error)
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
                completion(nil, error)
            }
        }
    }
}

