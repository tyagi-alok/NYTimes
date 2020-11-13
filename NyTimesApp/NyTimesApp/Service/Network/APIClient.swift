//
//  APIClient.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 12/11/20.
//  Copyright © 2020 Alok. All rights reserved.
//

import Foundation


final class APIClient {
    
    func load(_ resource: Resource, result: @escaping ((Result<Data,ErrorResult>) -> Void)) {
        let request = URLRequest(resource)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let `data` = data else {
                result(.failure(.noData))
                return
            }
            if let error = error {
                result(.failure(.network(string: error.localizedDescription)))
                return
            }
            result(.success(data))
        }
        task.resume()
    }
    
}
