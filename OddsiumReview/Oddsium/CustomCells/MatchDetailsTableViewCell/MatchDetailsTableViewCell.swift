//
//  MatchDetailsTableViewCell.swift
//  Oddsium
//
//  Created by Ansal Antony on 24/05/22.
//

import UIKit

class MatchDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var viewScore3: UIView!
    @IBOutlet weak var viewScore2: UIView!
    @IBOutlet weak var viewScore1: UIView!
    @IBOutlet weak var labelAmout: UILabel!
    @IBOutlet weak var imageViewlogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewScore1.layer.cornerRadius = self.viewScore1.frame.size.width/2
        self.viewScore1.layer.masksToBounds = true
        self.viewScore2.layer.cornerRadius = self.viewScore2.frame.size.width/2
        self.viewScore2.layer.masksToBounds = true
        self.viewScore3.layer.cornerRadius = self.viewScore3.frame.size.width/2
        self.viewScore3.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
