//
//  MatchScoreTableViewCell.swift
//  Oddsium
//
//  Created by Ansal Antony on 23/05/22.
//

import UIKit

class MatchScoreTableViewCell: UITableViewCell {

    @IBOutlet weak var labelDateTime: UILabel!
    @IBOutlet weak var imageViewFlag: UIImageView!
    @IBOutlet weak var labelLeague: UILabel!
    @IBOutlet weak var imageViewFootBall: UIImageView!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var imageViewLogo2: UIImageView!
    @IBOutlet weak var labelTeamName1: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelTeamName2: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var viewStatusIcon: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewStatusIcon.layer.cornerRadius = self.viewStatusIcon.frame.size.width/2
        self.viewStatusIcon.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
