//
//  AlertHelper.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/14.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import UIKit

struct AlertHelper {
    static func show(with title:String?, message:String? = nil, completion:(() -> ())?){
        guard let topViewController = AppDelegate.topViewController() , !(topViewController is UIAlertController) else {
            return
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        topViewController.present(alert, animated: true, completion: nil)
    }
}
