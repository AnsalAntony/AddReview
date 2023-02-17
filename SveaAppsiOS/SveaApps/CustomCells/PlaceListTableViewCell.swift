//
//  PlaceListTableViewCell.swift
//  SveaApps
//
//  Created by Ansal Antony on 16/02/23.
//

import UIKit
import SDWebImage

class PlaceListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelPlaceName: UILabel!
    @IBOutlet weak var imageViewPlace: UIImageView!
    @IBOutlet weak var viewInfo: UIView!
    @IBOutlet weak var buttonInfo: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewInfo.layer.cornerRadius = viewInfo.frame.height/2
        viewInfo.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(placeVal: PlaceList) {
        
        labelPlaceName.text = placeVal.name
        if let iconurl = placeVal.icon{
            let iconurlVal = APIConstants.baseUrl + iconurl
            imageViewPlace.sd_setImage(with: URL(string: iconurlVal), placeholderImage: UIImage(named: "placeholder.jpeg"))
        }
        
    }
    
}
