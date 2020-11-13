//
//  ArticleListProtocol.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 13/11/20.
//  Copyright © 2020 Alok. All rights reserved.
//

import Foundation

protocol ArticleListProtocol {
    func getData(atIndexPath: IndexPath)->Articles?
    func itemSelected(atIndexPath: IndexPath)
    func retrieveNumberOfSections()->Int
    func retrieveNumberOfItems()->Int
}
