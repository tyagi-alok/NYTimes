//
//  PopularArticleTableViewCell.swift
//  NyTimesApp
//
//  Created by Alok Tyagi on 12/11/20.
//  Copyright © 2020 Alok. All rights reserved.
//

import UIKit
import SDWebImage

class PopularArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var articlesCellViewModel : Articles? {
        didSet {
            
            titleLabel.text = articlesCellViewModel?.title ?? ""
            authorLabel.text = articlesCellViewModel?.byline ?? ""
            dateLabel.text = articlesCellViewModel?.publishedDate ?? ""

            if articlesCellViewModel?.media.count ?? ZERO > ZERO{
                if articlesCellViewModel?.media[ZERO].mediaMetadata.count ?? ZERO > TWO{
                    mainImageView?.sd_setImage(with: URL( string: articlesCellViewModel?.media[ZERO].mediaMetadata[ZERO].imageUrl ?? "" )) { (image, error, cache, urls) in
                        if (error != nil) {
                            self.mainImageView?.image = UIImage(named: PLACEHOLDER_IMAGE_STR)
                        } else {
                            self.mainImageView?.image = image
                        }
                    }
                }else{
                    mainImageView?.image = UIImage(named: PLACEHOLDER_IMAGE_STR)
                }
            }else{
                mainImageView?.image = UIImage(named: PLACEHOLDER_IMAGE_STR)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
