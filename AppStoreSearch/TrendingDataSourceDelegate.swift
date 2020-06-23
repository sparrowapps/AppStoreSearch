//
//  TrendingDataSourceDelegate.swift
//  AppStoreSearch
//
//  Created by Marcos Griselli on 14/07/2018.
//  Copyright © 2018 Marcos Griselli. All rights reserved.
//

import UIKit

class TrendingDataSourceDelegate: NSObject {
    private static let showCount = 20
    var terms = SearchHistory.get()
    var didSelect: (String) -> Void = { _ in }
}

extension TrendingDataSourceDelegate: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return terms.count > TrendingDataSourceDelegate.showCount ? TrendingDataSourceDelegate.showCount : terms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = terms[indexPath.row]
        return cell!
    }
}

extension TrendingDataSourceDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect(terms[indexPath.row])
    }
}
