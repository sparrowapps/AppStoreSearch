//
//  SearchDetailViewController.swift
//  AppStoreSearch
//
//  Created by sparrow on 2020/06/21.
//  Copyright © 2020 sparrowapps. All rights reserved.
//

import RxSwift
import UIKit
import RxCocoa

protocol AppsDetailViewControllerDelegate: class {
    func fetchLookup(complete success: @escaping (_ response: AppResponse) -> ())
}

final class AppsDetailViewController: UIViewController  {
    weak var delegate: AppsDetailViewControllerDelegate?
    
    var section = BehaviorRelay<[TableViewSection]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    deinit {
        Log.v("deinit")
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.alwaysBounceVertical = true
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "DescCell", bundle: nil), forCellReuseIdentifier: "DescCell")
        tableView.register(UINib(nibName: "MoreCell", bundle: nil), forCellReuseIdentifier: "MoreCell")
        tableView.register(UINib(nibName: "ReviewCell", bundle: nil), forCellReuseIdentifier: "ReviewCell")
        tableView.register(UINib(nibName: "NewCell", bundle: nil), forCellReuseIdentifier: "NewCell")
        tableView.register(UINib(nibName: "InfoCell", bundle: nil), forCellReuseIdentifier: "InfoCell")
        tableView.register(UINib(nibName: "HelperCell", bundle: nil), forCellReuseIdentifier: "HelperCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        
        bindTableView()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.pinToParent()
    }
    
    func bindTableView() {
        section.bind(to: tableView.rx.items) { [weak self] (tv, idx, ele) -> UITableViewCell in
            if tv.dequeueReusableCell(withIdentifier: "DescCell", for: IndexPath(row: idx, section: 0)) is DescCell{
                return (self?.section.value[idx].configureCell(tableView: tv, indexPath: IndexPath(row: idx, section: 0)))!
            }
            if tv.dequeueReusableCell(withIdentifier: "MoreCell", for: IndexPath(row: idx, section: 0)) is MoreCell{
                return (self?.section.value[idx].configureCell(tableView: tv, indexPath: IndexPath(row: idx, section: 0)))!
            }
            if tv.dequeueReusableCell(withIdentifier: "ReviewCell", for: IndexPath(row: idx, section: 0)) is ReviewCell{
                return (self?.section.value[idx].configureCell(tableView: tv, indexPath: IndexPath(row: idx, section: 0)))!
            }
            if tv.dequeueReusableCell(withIdentifier: "NewCell", for: IndexPath(row: idx, section: 0)) is NewCell{
                return (self?.section.value[idx].configureCell(tableView: tv, indexPath: IndexPath(row: idx, section: 0)))!
            }
            if tv.dequeueReusableCell(withIdentifier: "InfoCell", for: IndexPath(row: idx, section: 0)) is InfoCell{
                return (self?.section.value[idx].configureCell(tableView: tv, indexPath: IndexPath(row: idx, section: 0)))!
            }
            if tv.dequeueReusableCell(withIdentifier: "HelperCell", for: IndexPath(row: idx, section: 0)) is HelperCell{
                return (self?.section.value[idx].configureCell(tableView: tv, indexPath: IndexPath(row: idx, section: 0)))!
            }
            return UITableViewCell()
        }.disposed(by: disposeBag)
        
        delegate?.fetchLookup(complete: { [weak self] response in
            guard let apps = response.results.first else { return }
            self?.section.accept([
                DescSection(artWork: apps.icon,
                            trackName: apps.name,
                            screenshotUrls: apps.screenshots,
                            averageUserRating: apps.averageUserRating ?? 0.0,
                            userRatingCountForCurrentVersion: apps.userRatingCountForCurrentVersion ?? 0,
                            trackContentRating: apps.trackContentRating,
                            genre: apps.genre),
                
                MoreSection(description: apps.description,
                            sellerName: apps.artistName),
                
                ReviewSection(averageUserRating: apps.averageUserRating ?? 0.0,
                              userRatingCountForCurrentVersion: apps.userRatingCountForCurrentVersion ?? 0,
                              answers: []),
                
                NewSection(version: apps.version,
                           beforeDay: "",
                           releaseNotes: apps.releaseNotes ?? ""),
                
                InfoSection(sellerName: apps.sellerName,
                            fileSizeBytes: apps.fileSizeBytes,
                            genre: apps.genre,
                            trackContentRating: apps.trackContentRating),
                
                HelperSection()
            ])
        })
    }
}

