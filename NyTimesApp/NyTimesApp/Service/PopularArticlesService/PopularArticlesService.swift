//
//  PopularArticlesService.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 12/11/20.
//  Copyright © 2020 Alok. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
    func getPopularArtciles(_ completion: @escaping ((Result<PopularArticlesModel,ErrorResult>) -> Void))
}

final class PopularArticlesService:APIServiceProtocol {
    
    typealias GetArticlesResult = Result<PopularArticlesModel,ErrorResult>
    typealias GetArticlesCompletion = (_ result: GetArticlesResult) -> Void

    private let apiClient: APIClient!
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getPopularArtciles(_ completion: @escaping GetArticlesCompletion) {
        let resource = Resource(url: URL(string:AppURL.SeeAllPopularArticles)!)
        apiClient.load(resource) { (result) in
            switch result {
            case .success(let data):
                do {
                    let items = try JSONDecoder().decode(PopularArticlesModel.self, from: data)
                    completion(.success(items))
                } catch(let error) {
                    print(error.localizedDescription)
                    completion(.failure(.network(string: "No data!")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
