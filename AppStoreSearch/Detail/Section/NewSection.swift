//  AppStoreSearch
//
//  Created by sparrow on 2020/06/21.
//  Copyright © 2020 sparrowapps. All rights reserved.
//

import UIKit
import RxSwift

struct NewSection: TableViewSection {
    let numberOfItems = 1

    let version: String
    let beforeDay: String
    let releaseNotes: String

    init(version: String, beforeDay: String, releaseNotes: String) {
        self.version = version
        self.beforeDay = beforeDay
        self.releaseNotes = releaseNotes
    }
    
    func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewCell", for: indexPath) as? NewCell{
            cell.versionLabel.text = "버전 \(version)"
            cell.beforeDayLabel.text = beforeDay
            cell.descriptionLabel.text = releaseNotes
            return cell
        }
        return UITableViewCell()
    }
}
