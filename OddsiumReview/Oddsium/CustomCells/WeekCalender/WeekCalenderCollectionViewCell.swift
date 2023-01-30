//
//  WeekCalenderCollectionViewCell.swift
//  Oddsium
//
//  Created by Ansal Antony on 27/05/22.
//

import UIKit

class WeekCalenderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelWeek: UILabel!
    @IBOutlet weak var ViewSelection: UIView!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var viewRound: UIView!
    @IBOutlet weak var labelDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewRound.layer.cornerRadius = self.viewRound.frame.size.width/2
        self.viewRound.layer.masksToBounds = true
    }

}
