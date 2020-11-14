//
//  PopularArticlesListViewController.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 11/11/20.
//  Copyright © 2020 Alok. All rights reserved.
//

import UIKit

class PopularArticlesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var adapter : PopularArticlesListAdapter!

    //lazy initialization of view Model
    lazy var viewModel: PopularArticlesListViewModel = {
        return PopularArticlesListViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Init the static view
        initView()
        
        // init view model
        initVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //set up Nav Bar
        setUpNavBar()
    }
    
    // MARK: - Set up UI functions
    func setUpNavBar(){
        
        navigationController?.navigationBar.barTintColor = navigationBarTintColor

        // Navigation Bar Text:
        let attributes = [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Medium", size: 22)!, NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = attributes

    }
    
    func initView() {
        
        adapter = PopularArticlesListAdapter(delegate: self)
        tableView.delegate = adapter
        tableView.dataSource = adapter

        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
    }

    func initVM() {
        
        // Naive binding
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
        
        //For show/hide loader
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 0.0
                    })
                }else {
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 1.0
                    })
                }
            }
        }
        
        // for reloading tableview after response
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.initFetch()

    }
    
// MARK: - Get show Alert
  private func showAlert( _ message: String ) {
        let alert = UIAlertController(title: ALERT_TITLE, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: ALERT_OK_BUTTON_TITLE, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Segue
//Overriding the segue
extension PopularArticlesListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? PopularArticlesDetailViewController,let artcile = viewModel.getCellViewModel(at: viewModel.selectedIndexPath!),artcile.abstract != nil{
            vc.titleStr = artcile.title
            vc.abstractStr = artcile.abstract
            if artcile.media.count > ZERO{
                if artcile.media[ZERO].mediaMetadata.count > TWO{
                    vc.imageUrl = artcile.media[ZERO].mediaMetadata[TWO].imageUrl
                }else{
                    vc.imageUrl = ""
                }
            }else{
                  vc.imageUrl = ""
            }
        }
    }
}

// MARK: - protocol methods
//Conforming to the protocols for the adapter class
extension PopularArticlesListViewController : ArticleListProtocol {
    func getData(atIndexPath: IndexPath) -> Articles? {
        return viewModel.getCellViewModel(at: atIndexPath)
    }
    
    
    func itemSelected(atIndexPath: IndexPath) {
        self.viewModel.userPressed(at: atIndexPath)
    }
    
    
    func retrieveNumberOfSections()->Int {
        return ONE
    }

    func retrieveNumberOfItems()->Int {
        return self.viewModel.numberOfCells
    }
}
