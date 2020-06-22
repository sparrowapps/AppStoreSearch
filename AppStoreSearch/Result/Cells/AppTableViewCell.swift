//
//  AppTableViewCell.swift
//  AppStoreSearch
//
//  Created by Marcos Griselli on 14/07/2018.
//  Copyright © 2018 Marcos Griselli. All rights reserved.
//

import UIKit
import Cosmos
import RxSwift

class AppTableViewCell: UITableViewCell, ReusableView, NibLoadableView {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenshotStackView: UIStackView!
    @IBOutlet weak var starRatingView: CosmosView!
    @IBOutlet weak var ratingCountLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    var screenshotImageViews: [UIImageView] {
        return screenshotStackView.arrangedSubviews as! [UIImageView]
    }
    
    func configure(app: App) {
        nameLabel.text = app.name
        genreLabel.text = app.genre
        starRatingView.rating = app.averageUserRatingForCurrentVersion ?? 0.0
        ratingCountLabel.text = makeratingCountLabel(value: app.userRatingCountForCurrentVersion)
        
        iconImageView
            .rx_setImage(by: app.icon)
            .disposed(by: disposeBag)
        for (index, screenshot) in app.screenshots.enumerated() {
            screenshotImageViews[safe: index]?
                .rx_setImage(by: screenshot)
                .disposed(by: disposeBag)
        }
    }
    
    func cancel() {
    }
    
    private func makeratingCountLabel(value: Int?) -> String {
        guard let userRatingCount = value else { return "" }
        let ratingCountText = { (number: Double) -> String in
            var count = Double(userRatingCount) / number

            let divisor = pow(10.0, Double(2))
            count = (count * divisor).rounded(.up) / divisor
            
            return String(format: "%.1f", count)
        }
        
        var ratingText = String(userRatingCount)
        
        if userRatingCount > 10000 {
            ratingText = "\(ratingCountText(10000.0))만"
        } else if userRatingCount > 1000 {
            ratingText = "\(ratingCountText(1000.0))천"
        }
        
        return ratingText
    }
}
