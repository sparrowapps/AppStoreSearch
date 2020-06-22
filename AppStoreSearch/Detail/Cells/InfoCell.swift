//
//  InfoCell.swift
//  AppStoreSearch
//
//  Created by sparrow on 2020/06/21.
//  Copyright © 2020 sparrowapps. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var fileSizeLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var trackContentRatingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func compatitableButtonClick(_ sender: UIButton) {
    }
    @IBAction func developerWebSiteButtonClick(_ sender: Any) {
    }
    @IBAction func privacyButtonClick(_ sender: Any) {
    }
    
}
