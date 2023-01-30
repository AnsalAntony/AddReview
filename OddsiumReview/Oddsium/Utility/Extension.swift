//
//  Extension.swift
//  Oddsium
//
//  Created by Ansal Antony on 22/05/22.
//

import Foundation
import UIKit

extension UIView {
    
    // MARK: - Setting app gradient background color
    
    func applyGradient(colorArray: [UIColor]) {
        layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray.map({ $0.cgColor })
        gradientLayer.locations = [0.0, 1.0]
        backgroundColor = .clear
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

// MARK: - alert View
extension UIViewController {
    
    func  alertPresent(title: String, message: String) {
        let alert = UIAlertController(title:title, message:message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
//MARK:- formating Date String 
extension String {
    
    func dateTimeFormate(outPutFormate:String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = AppConstants.inputDateFormat
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = outPutFormate
        
        let date: Date? = dateFormatterGet.date(from: self)
        var dateString = ""
        if(date != nil){
            dateString = dateFormatterPrint.string(from: date!);
        }
        return dateString
    }
}

//MARK:- Take Current Date
extension Date {
    
    static func getCurrentDate(outPutFormat:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = outPutFormat
        let dtString = dateFormatter.string(from: Date())
        
        return dtString
    }
    
}

