//  AppStoreSearch
//
//  Created by sparrow on 2020/06/21.
//  Copyright © 2020 sparrowapps. All rights reserved.
//

import UIKit
import RxSwift

struct DescSection: TableViewSection {
    let numberOfItems = 1

    let artWork: String
    let trackName: String
    let screenshotUrls: [String]
    let averageUserRating: Double
    let userRatingCountForCurrentVersion: Int
    let trackContentRating: String
    let genre: String
    
    
    private let disposeBag = DisposeBag()

    init(artWork: String,
         trackName: String,
         screenshotUrls: [String],
         averageUserRating: Double,
         userRatingCountForCurrentVersion: Int,
         trackContentRating: String,
         genre: String) {
        self.artWork = artWork
        self.trackName = trackName
        self.screenshotUrls = screenshotUrls
        self.averageUserRating = averageUserRating
        self.userRatingCountForCurrentVersion = userRatingCountForCurrentVersion
        self.trackContentRating = trackContentRating
        self.genre = genre
        
    }
    
    func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DescCell", for: indexPath) as? DescCell{
            cell.artWork
                .rx_setImage(by: artWork)
                .disposed(by: disposeBag)
            
            cell.url.accept(screenshotUrls)
            cell.trackName.text = trackName
            
            cell.starRatingView.rating = averageUserRating
            cell.ratingCountLabel.text = String(format: "%.1f", averageUserRating)
            cell.reviewCountLabel.text = makeratingCountLabel(value: userRatingCountForCurrentVersion) + "개의 평가"
            
            cell.trackContentRatingLabel.text = trackContentRating
            cell.genreLabel.text = genre
            return cell
        }
        return UITableViewCell()
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
