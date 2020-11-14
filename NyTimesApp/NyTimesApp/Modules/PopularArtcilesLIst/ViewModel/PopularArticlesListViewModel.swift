//
//  PopularArticlesLIstViewModel.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 11/11/20.
//  Copyright © 2020 Alok. All rights reserved.
//

import Foundation

class PopularArticlesListViewModel {
    
    let apiService: APIServiceProtocol
    
    var cellViewModels: PopularArticlesModel? {
    didSet {
        self.reloadTableViewClosure?()
    }
}
    
    // MARK: - Computed properties
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels?.resultsNumber ?? 0
    }
    
    var selectedIndexPath: IndexPath?
    
    // MARK: - CallBack Handlers
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?

    // MARK: - Constructor
    init( apiService: APIServiceProtocol = PopularArticlesService(apiClient: APIClient())) {
        self.apiService = apiService
    }
    
    // MARK: - API
    
    /*--calling api to fetch popular articles--*/
    func initFetch() {
        self.isLoading = true
        apiService.getPopularArtciles {[weak self] (result) in
            self?.isLoading = false
            switch result{
            case .success(let data):
                self?.cellViewModels = data
            case .failure(let error):
                self?.alertMessage = error.localizedDescription
            }
        }
    }
    
    
    // MARK: - Get CellModel
    func getCellViewModel( at indexPath: IndexPath ) -> Articles? {
            return cellViewModels?.articles[indexPath.row]
    }
}

// MARK: - Extension
extension PopularArticlesListViewModel {
    func userPressed( at indexPath: IndexPath ){
        self.selectedIndexPath = indexPath
    }
}
