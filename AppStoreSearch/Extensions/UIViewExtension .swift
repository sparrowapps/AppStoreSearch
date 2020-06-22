//
//  UIViewExtension .swift
//  AppStoreSearch
//
//  Created by sparrow on 2020/06/21.
//  Copyright © 2020 sparrowapps. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func pinToParent(){
        guard let p = self.superview else { return }
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: p.topAnchor),
            self.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: p.bottomAnchor)])
    }
}
