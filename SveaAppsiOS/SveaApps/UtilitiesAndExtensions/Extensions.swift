//
//  Extensions.swift
//  SveaApps
//
//  Created by Ansal Antony on 13/02/23.
//

import Foundation
import UIKit

// MARK: - alert View
extension UIViewController {
    
    func  alertPresent(title: String, message: String) {
        let alert = UIAlertController(title:title, message:message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIView {
    // MARK: - craeting shado for view
    func setBackgroundShadow(setColor: UIColor) {
        //MARK:- Shade a view
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1.0)
        self.layer.shadowRadius = 5
        self.layer.shadowColor = setColor.cgColor
        self.layer.masksToBounds = false
    }
}

