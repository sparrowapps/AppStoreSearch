//  AppStoreSearch
//
//  Created by sparrow on 2020/06/21.
//  Copyright © 2020 sparrowapps. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct ReviewSection: TableViewSection {
    let numberOfItems = 1

    let averageUserRating: Double
    let userRatingCountForCurrentVersion: Int
    let answers: [String]

    init(averageUserRating: Double, userRatingCountForCurrentVersion: Int, answers: [String]) {
        self.averageUserRating = averageUserRating
        self.userRatingCountForCurrentVersion = userRatingCountForCurrentVersion
        self.answers = answers
    }
    
    func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as? ReviewCell{

            cell.ratingCountLabel.text = String(format: "%.1f", averageUserRating)
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            cell.reviewCountLabel.text = numberFormatter.string(from: NSNumber(value:userRatingCountForCurrentVersion))! + "개의 평가"
            
            return cell
        }
        return UITableViewCell()
    }
}
