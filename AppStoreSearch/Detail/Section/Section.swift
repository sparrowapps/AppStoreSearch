//  AppStoreSearch
//
//  Created by sparrow on 2020/06/21.
//  Copyright © 2020 sparrowapps. All rights reserved.
//

import UIKit

protocol TableViewSection {
    var numberOfItems: Int { get }    
    func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    
}
