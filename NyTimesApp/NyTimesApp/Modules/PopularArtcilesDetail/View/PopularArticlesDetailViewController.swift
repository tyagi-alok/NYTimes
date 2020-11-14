//
//  PopularArticlesDetailViewController.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 13/11/20.
//  Copyright © 2020 Alok. All rights reserved.
//

import UIKit

class PopularArticlesDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var abstractLabel:UILabel!
    @IBOutlet weak var mainImageView:UIImageView!
    
    var imageUrl: String?
    var abstractStr:String?
    var titleStr:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the UI values
        populateUIData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - UI Set Up Functions
    private func populateUIData(){
        if let title = titleStr{
            titleLabel.text = title
        }
        
        if let abstract = abstractStr{
            abstractLabel.text = abstract
        }
        
        if let image = imageUrl{
            mainImageView?.sd_setImage(with: URL(string: image)) { (image, error, cache, urls) in
                if (error != nil) {
                    self.mainImageView?.image = UIImage(named: DETAIL_PLACEHOLDER_IMAGE_STR)
                } else {
                    self.mainImageView?.image = image
                }
            }

        }
    }
}
