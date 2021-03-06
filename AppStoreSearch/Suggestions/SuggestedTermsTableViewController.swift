//
//  SuggestedTermsTableViewController.swift
//  Canillitapp
//
//  Created by Marcos Griselli on 14/07/2018.
//  Copyright © 2018 Ezequiel Becerra. All rights reserved.
//

import UIKit

class SuggestedTermsTableViewController: UITableViewController {
    
    var searchedTerm = String() {
        didSet {
            currentNames = namesWith(prefix: searchedTerm)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var terms = SearchHistory.get()
    private var currentNames = [String]()
    var didSelect: (String) -> Void = { _ in }
    
    deinit {
        Log.v("deinit")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SuggestedTermTableViewCell
        cell.set(term: currentNames[indexPath.row],
                 searchedTerm: searchedTerm)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect(currentNames[indexPath.row])
    }
    
    func namesWith(prefix: String) -> [String] {
        return terms
            .filter{ $0.hasCaseInsensitivePrefix(prefix) }
            .map{ $0 }
    }
}
