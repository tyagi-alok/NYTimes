//
//  PopularArticlesListAdapter.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 13/11/20.
//  Copyright © 2020 Alok. All rights reserved.
//

import UIKit

class PopularArticlesListAdapter: NSObject {

    let delegate: ArticleListProtocol

    // MARK: - Constructor

    init(delegate:ArticleListProtocol) {
        self.delegate = delegate
    }
}

// MARK: - UITableViewDataSource Delegate implementation

extension PopularArticlesListAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopularArticlesListViewController", for: indexPath) as? PopularArticleTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }

       
        cell.articlesCellViewModel = delegate.getData(atIndexPath: indexPath )

        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return delegate.retrieveNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate.retrieveNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
        
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        delegate.itemSelected(atIndexPath: indexPath)
        return indexPath
    }

}


