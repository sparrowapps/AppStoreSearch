//
//  DescCell.swift
//  AppStoreSearch
//
//  Created by sparrow on 2020/06/21.
//  Copyright © 2020 sparrowapps. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Cosmos

class DescCell: UITableViewCell {
    @IBOutlet weak var artWork: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var screenCV: UICollectionView!
    @IBOutlet weak var starRatingView: CosmosView!
    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    
    @IBOutlet weak var categoryRankLabel: UILabel!
    @IBOutlet weak var trackContentRatingLabel: UILabel! //연령
    @IBOutlet weak var genreLabel: UILabel!
    
    var url = BehaviorRelay<[String]>(value: [])
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        screenCV.register(UINib(nibName: "DescScreenCell", bundle: nil), forCellWithReuseIdentifier: "DescScreenCell")
        configureCV()        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCV(){
        let disposeBag = DisposeBag()

        url.bind(to: self.screenCV.rx.items(cellIdentifier: "DescScreenCell", cellType: DescScreenCell.self)) { (idx, url, cell) in
            cell.screenShotImageView
                .rx_setImage(by: url)
                .disposed(by: disposeBag)
        }
        .disposed(by: disposeBag)
    }
    
    @IBAction func downLoadButtonClick(_ sender: UIButton) {
        
    }
    @IBAction func shareButtonClick(_ sender: UIButton) {
        
    }
    
}
