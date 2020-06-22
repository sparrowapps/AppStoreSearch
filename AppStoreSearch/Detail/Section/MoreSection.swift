//  AppStoreSearch
//
//  Created by sparrow on 2020/06/21.
//  Copyright © 2020 sparrowapps. All rights reserved.
//

import UIKit
import RxSwift

struct MoreSection: TableViewSection {
    let numberOfItems = 1

    let description: String
    let sellerName: String

    init(description: String, sellerName: String) {
        self.description = description
        self.sellerName = sellerName
    }
    
    func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell", for: indexPath) as? MoreCell{
            cell.descriptionLabel.text = description
            cell.sellerNameLabel.text = sellerName
            return cell
        }
        return UITableViewCell()
    }
    
}
