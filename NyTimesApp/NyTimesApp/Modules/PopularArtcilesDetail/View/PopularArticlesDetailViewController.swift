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
        
        //init the UI
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setUpUI(){
        if let title = titleStr{
            titleLabel.text = title
        }
        
        if let abstract = abstractStr{
            abstractLabel.text = abstract
        }
        if let image = imageUrl{
            mainImageView?.sd_setImage(with: URL( string: image), completed: nil)
        }
        
    }
}
