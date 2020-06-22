//
//  DescScreenCell.swift
//  AppStoreSearch
//
//  Created by sparrow on 2020/06/21.
//  Copyright © 2020 sparrowapps. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DescScreenCell: UICollectionViewCell {
    @IBOutlet weak var screenShotImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func prepareForReuse() {
        super.prepareForReuse()
    }
}
