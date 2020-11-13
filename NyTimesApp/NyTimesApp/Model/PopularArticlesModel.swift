//
//  PopularArticlesModel.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 12/11/20.
//  Copyright © 2020 Alok. All rights reserved.
//

import Foundation

struct PopularArticlesModel: Codable {
    let status:String?
    let resultsNumber:Int?
    let articles: [Articles]
    enum CodingKeys:String, CodingKey{
        case status = "status"
        case resultsNumber = "num_results"
        case articles = "results"
    }
}

struct Articles: Codable {
    let publishedDate: String?
    let title: String?
    let abstract: String?
    let byline: String?
    let id: Int64?
    let media:[Media]
    
    enum CodingKeys:String, CodingKey{
        case publishedDate = "published_date"
        case title
        case abstract
        case media
        case byline
        case id
    }
}

struct Media:Codable{
    let mediaMetadata:[Metadata]
    enum CodingKeys:String, CodingKey{
        case mediaMetadata = "media-metadata"
    }
}

struct Metadata:Codable {
    let imageUrl:String?
    
    enum CodingKeys:String, CodingKey{
        case imageUrl = "url"
    }
}

extension PopularArticlesModel {
    static func with(status: String = "OK",
                     resultsNumber: Int = 10,
                     articles: [Articles] = [Articles(publishedDate: "10-11-2020", title: "saasada", abstract: "asdadss", byline: "asdsd", id: 11234567, media: [])]) -> PopularArticlesModel
    {
        return PopularArticlesModel(status: status, resultsNumber: resultsNumber, articles: articles)
    }
}

