//  AppStoreSearch
//
//  Created by sparrow on 2020/06/21.
//  Copyright © 2020 sparrowapps. All rights reserved.
//

import UIKit
import RxSwift

struct HelperSection: TableViewSection {
    let numberOfItems = 1

    init() {}
    
    func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HelperCell", for: indexPath) as? HelperCell{
            
            return cell
        }
        return UITableViewCell()
    }
}
