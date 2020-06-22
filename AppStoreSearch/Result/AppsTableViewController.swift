//
//  AppsTableViewController.swift
//  AppStoreSearch
//
//  Created by Marcos Griselli on 14/07/2018.
//  Copyright © 2018 Marcos Griselli. All rights reserved.
//

import UIKit

class AppsTableViewController: UITableViewController, AppsDetailViewControllerDelegate {
    
    var apps = [App]()
    var dataTask: URLSessionDataTask?
    var nav: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(AppTableViewCell.self)
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AppTableViewCell =
            tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(app: apps[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? AppTableViewCell else { return }
        cell.cancel()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var searchDetailVC: AppsDetailViewController!
        
        searchDetailVC =  storyboard.instantiateViewController(withIdentifier: "SearchDetailViewController") as? AppsDetailViewController
        searchDetailVC.delegate = self
        self.id = apps[indexPath.row].trackID
        
        self.nav?.pushViewController(searchDetailVC, animated: true)
    }
    
    // MARK: - AppsDetailViewControllerDelegate
    private var id: Int = -1
    func fetchLookup(withSuccessHandler success: @escaping (_ response: AppResponse) -> ()) {
        dataTask?.cancel()
        let url = URL(string: "https://itunes.apple.com/lookup?id=\(id)&country=kr&lang=ko_kr")!
        dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                
                let response = try JSONDecoder().decode(AppResponse.self, from: data)
                
                success(response)
            } catch {
                print(error)
            }
        }
        dataTask?.resume()
    }

    /// Searches the input on https://itunes.apple.com/.
    /// For the purpose of a simple blog post this is network call
    /// is placed on the view controller.
    ///
    /// - Parameter term: Term to search.
    func search(term: String) {
        dataTask?.cancel()
        let encodedTerm = term
            .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = URL(string: "https://itunes.apple.com/search?term=\(encodedTerm ?? String())&entity=software,iPadSoftware&limit=10&country=kr&lang=ko_kr")!
        dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(AppResponse.self, from: data)
                
                self.handle(response: response)
            } catch {
                print(error)
            }
        }
        dataTask?.resume()
    }
    
    /// Handles the networking response with the searched apps.
    ///
    /// - Parameter response: AppResponse retrieved from the network.
    private func handle(response: AppResponse) {
        apps = response.results
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
