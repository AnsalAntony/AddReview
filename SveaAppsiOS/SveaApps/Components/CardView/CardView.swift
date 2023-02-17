//
//  CardView2.swift
//  DentalCare
//
//  Created by Ansal Antony on 10/12/22.
//

import UIKit

@IBDesignable class CardView: UIView {
    
    
    @IBInspectable var bgcolor: UIColor? {
        didSet{
            self.backgroundColor = bgcolor
            
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 7 {
        didSet{
            self.layer.cornerRadius = cornerRadius
            
        }
    }
    @IBInspectable var BackgroundShadow: UIColor = UIColor.black {
        didSet{
            self.setBackgroundShadow(setColor: BackgroundShadow)
            
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet{
            self.layer.borderWidth = borderWidth
            
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet{
            self.layer.borderColor = borderColor.cgColor
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 7
        self.layer.masksToBounds = true
        self.setBackgroundShadow(setColor: UIColor.black)
    }
    
}
