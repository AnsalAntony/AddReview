//
//  PlaceDetailViewController.swift
//  SveaApps
//
//  Created by Ansal Antony on 16/02/23.
//

import UIKit

class PlaceDetailViewController: UIViewController {
    
    @IBOutlet weak var imageViewplace: UIImageView!
    @IBOutlet weak var labelPlaceName: UILabel!
    @IBOutlet weak var labelLong: UILabel!
    @IBOutlet weak var labelLat: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var buttonKnowMore: UIButton!
    @IBOutlet weak var viewLine: UIView!
    
    var placeDetails: PlaceList? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
    }
    
    private func bindData(){
        labelPlaceName.text = placeDetails?.name ?? ""
        if let imgUrl = placeDetails?.icon{
            imageViewplace.sd_setImage(with: URL(string: APIConstants.baseUrl + imgUrl), placeholderImage: UIImage(named: "placeholder.jpeg"))
        }
        if let long = placeDetails?.longitude, let lat = placeDetails?.latitude {
            labelLat.text = String(format: "%.2f", lat)
            labelLong.text = String(format: "%.2f", long)
        }
        labelDescription.text = placeDetails?.description
        if (placeDetails?.website != "" && placeDetails?.website != nil){
            buttonKnowMore.isHidden = false
            viewLine.isHidden = false
        }else{
            buttonKnowMore.isHidden = true
            viewLine.isHidden = true
        }
        
    }
    
    static func make() -> PlaceDetailViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.storyboardId.placeDetail) as! PlaceDetailViewController
        return viewController
    }
    
    @IBAction func buttonKnowMoreClicked(_ sender: Any) {
        if let url = URL(string: placeDetails?.website ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
}
