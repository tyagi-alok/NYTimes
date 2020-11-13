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
    

    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?

    init( apiService: APIServiceProtocol = PopularArticlesService(apiClient: APIClient())) {
        self.apiService = apiService
    }
    
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
    
    
    func getCellViewModel( at indexPath: IndexPath ) -> Articles? {
            return cellViewModels?.articles[indexPath.row]
    }
    
//    func createCellViewModel( photo: Photo ) -> PhotoListCellViewModel {
//
//        //Wrap a description
//        var descTextContainer: [String] = [String]()
//        if let camera = photo.camera {
//            descTextContainer.append(camera)
//        }
//        if let description = photo.description {
//            descTextContainer.append( description )
//        }
//        let desc = descTextContainer.joined(separator: " - ")
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//
//        return PhotoListCellViewModel( titleText: photo.name,
//                                       descText: desc,
//                                       imageUrl: photo.image_url,
//                                       dateText: dateFormatter.string(from: photo.created_at) )
//    }
    
//    private func processFetchedPhoto( photos: [Photo] ) {
//        self.photos = photos // Cache
//        var vms = [PhotoListCellViewModel]()
//        for photo in photos {
//            vms.append( createCellViewModel(photo: photo) )
//        }
//        self.cellViewModels = vms
//    }
//
}

extension PopularArticlesListViewModel {
    func userPressed( at indexPath: IndexPath ){
        self.selectedIndexPath = indexPath
    }
}
