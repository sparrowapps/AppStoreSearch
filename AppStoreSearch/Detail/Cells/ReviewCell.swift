//
//  ReviewCell.swift
//  AppStoreSearch
//
//  Created by sparrow on 2020/06/21.
//  Copyright © 2020 sparrowapps. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var answerCV: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func showAllButtonClick(_ sender: UIButton) {
    }
    
}
