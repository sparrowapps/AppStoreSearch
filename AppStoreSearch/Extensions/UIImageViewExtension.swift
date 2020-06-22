//
//  UIImageViewExtension.swift
//  appstoreSearch
//
//  Created by Elon on 20/03/2019.
//  Copyright © 2019 Elon. All rights reserved.
//

import UIKit
import RxSwift

extension UIImageView {
    
    func rx_setImage(by urlString: String) -> Disposable {
        return Network.shared.requestImage(urlString: urlString)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .retry(2)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] imageData in
                self?.image = UIImage(data: imageData)
                }, onError: { error in
                    Log.e(error.localizedDescription)
            })
    }
}
