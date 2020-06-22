//  AppStoreSearch
//
//  Created by sparrow on 2020/06/21.
//  Copyright © 2020 sparrowapps. All rights reserved.
//

import UIKit
import RxSwift

struct InfoSection: TableViewSection {
    let numberOfItems = 1

    let sellerName: String
    let fileSizeBytes: String
    let genre: String
    let trackContentRating: String

    init(sellerName: String, fileSizeBytes: String, genre: String, trackContentRating: String) {
        self.sellerName = sellerName
        self.fileSizeBytes = fileSizeBytes
        self.genre = genre
        self.trackContentRating = trackContentRating
    }
    
    func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell{
            
            cell.sellerNameLabel.text = sellerName
            let fileSize = Int64((fileSizeBytes as NSString).integerValue)
            let fileSizeWithUnit = ByteCountFormatter.string(fromByteCount: fileSize, countStyle: .file)
            
            cell.fileSizeLabel.text = fileSizeWithUnit
            
            cell.genreLabel.text = genre
            cell.trackContentRatingLabel.text = trackContentRating
            
            return cell
        }
        return UITableViewCell()
    }
}
