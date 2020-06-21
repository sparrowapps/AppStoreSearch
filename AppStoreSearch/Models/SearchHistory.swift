//
//  SearchHistory.swift
//  AppStoreSearch
//
//  Created by sparrow on 2020/06/21.
//  Copyright © 2020 sparrowapps. All rights reserved.
//

import Foundation

struct SearchHistory {
    private static let key = "SearchHistory"
    private static let capacity = 100
    
    static func get() -> [String] {
        let history = UserDefaults.standard.array(forKey: key)
        return history as? [String] ?? [String]()
    }
    
    static private func set(_ value: [String]) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func insert(_ value: String) {
        var history = get()
        
        for (index, element) in history.enumerated() {
            if element == value {
                history.remove(at: index)
                break
            }
        }
        
        history.insert(value, at: 0)
        
        while history.count > capacity {
            history.removeLast()
        }
        
        set(history)
    }
}
