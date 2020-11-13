//
//  Result.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 12/11/20.
//  Copyright © 2020 Alok. All rights reserved.
//

import Foundation

enum Result<T,E: Error>{
    case success(T)
    case failure(E)
}

enum ErrorResult: Error {
    case network(string: String)
    case cancel(string: String)
    case custom(string: String)
    case noData
}
