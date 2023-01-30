//
//  MatchDetailsViewController.swift
//  Oddsium
//
//  Created by Ansal Antony on 23/05/22.
//

import UIKit
import SDWebImage

class MatchDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableViewMatchDetails: UITableView!
    @IBOutlet weak var imageViewInfo: UIImageView!
    @IBOutlet weak var imageViewTv: UIImageView!
    @IBOutlet weak var labelTeamTitle: UILabel!
    @IBOutlet weak var imageViewFlag: UIImageView!
    @IBOutlet weak var imageViewBack: UIImageView!
    @IBOutlet weak var collectionViewTitles: UICollectionView!
    @IBOutlet weak var labelDateTime: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelLiveStatus: UILabel!
    @IBOutlet weak var viewProgressParent: UIView!
    @IBOutlet weak var viewProgress: UIView!
    @IBOutlet weak var imageViewTeamLogo1: UIImageView!
    @IBOutlet weak var labelNameTeam1: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelNameTeam2: UILabel!
    @IBOutlet weak var imageViewTeamLogo2: UIImageView!
    @IBOutlet weak var constraintProgress: NSLayoutConstraint!
    
    
    var titleSelectedIndex = 0
    var matchDetailViewModel = MatchDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNib()
        self.seupUi()
        self.matchDetailServiceCall()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        self.matchDetailViewModel.removeMatchUpdateTimer()
        super.viewWillDisappear(animated)
    }
    
    
    func setupNib(){
        self.collectionViewTitles.register(UINib(nibName: AppConstants.MatchTitleCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: AppConstants.MatchTitleCollectionViewCell)
        self.tableViewMatchDetails.register(UINib(nibName: AppConstants.MatchDetailsTableViewCell, bundle: nil), forCellReuseIdentifier: AppConstants.MatchDetailsTableViewCell)
    }
    func seupUi(){
        self.view.applyGradient(colorArray: [.darkGray, .lightGray])
        self.imageViewBack.image = imageViewBack.image?.withRenderingMode(.alwaysTemplate)
        self.imageViewBack.tintColor = UIColor.white
        self.imageViewTv.image = imageViewTv.image?.withRenderingMode(.alwaysTemplate)
        self.imageViewTv.tintColor = UIColor.white
    }
    
    func matchDetailServiceCall() {
        ProgressiveLoader.sharedInstance.showLoader(target: self, title:AppConstants.PleaseWait)
        DispatchQueue.main.async {
            self.matchDetailViewModel.getGameDetails()
        }
        self.matchDetailViewModel.matchDetailCompletionHandler { [weak self] (status, errorTitle, errormesg) in
            guard let self = self else {return}
            if status {
                ProgressiveLoader.sharedInstance.dismissLoader(target: self)
                self.matchDetailDtaBinding()
            } else {
                ProgressiveLoader.sharedInstance.dismissLoader(target: self)
                self.alertPresent(title: errorTitle, message: errormesg)
            }
        }
    }
    
    func matchDetailDtaBinding(){
        
        let matchDta = matchDetailViewModel.matchDetails
        self.labelTeamTitle.text = matchDta?.data?.tournament_name ?? ""
        let leagueImgUrl =  matchDetailViewModel.appendImgBaseUrls(subUrl: matchDta?.data?.tournament_flag_url ?? "")
        self.imageViewFlag.sd_setImage(with: URL(string: leagueImgUrl), placeholderImage: UIImage(named: "flag.png"))
        self.labelDateTime.text = matchDta?.data?.date?.dateTimeFormate(outPutFormate:AppConstants.outPutDateFormat)
        self.labelStatus.text = matchDta?.data?.status ?? ""
        self.labelLiveStatus.text = matchDetailViewModel.liveStatus(status: matchDta?.data?.status ?? "", liveStatus:matchDta?.data?.live_status ?? "" )
        let ht_flag_url =  matchDetailViewModel.appendImgBaseUrls(subUrl: matchDta?.data?.ht_flag_url ?? "")
        self.imageViewTeamLogo1.sd_setImage(with: URL(string: ht_flag_url), placeholderImage: UIImage(named: "flag.png"))
        let at_flag_url =  matchDetailViewModel.appendImgBaseUrls(subUrl: matchDta?.data?.at_flag_url ?? "")
        self.imageViewTeamLogo2.sd_setImage(with: URL(string: at_flag_url), placeholderImage: UIImage(named: "flag.png"))
        self.labelNameTeam1.text = matchDta?.data?.ht_name ?? ""
        self.labelNameTeam2.text = matchDta?.data?.at_name ?? ""
        self.labelScore.text = "0" + " - " + "0"
        if let htScore = matchDta?.data?.ht_score, let atScore = matchDta?.data?.at_score{
            self.labelScore.text = htScore + " - " + atScore
        }
        self.constraintProgress.constant = CGFloat(matchDetailViewModel.setupProgressBar(status: matchDta?.data?.status ?? "", progressBar: matchDta?.data?.progress_bar ?? ""))
        self.imageViewTv.isHidden = true
        if(matchDetailViewModel.has_stream){
            self.imageViewTv.isHidden = false
        }
        
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tvClicked(_ sender: Any) {
        
    }
    @IBAction func ibuttonClicked(_ sender: Any) {
        
    }
}
extension MatchDetailsViewController:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppConstants.titleData.count
    }
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            return CGSize(width: 138, height: 120);
//        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : MatchTitleCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.MatchTitleCollectionViewCell, for: indexPath) as! MatchTitleCollectionViewCell
        let data = AppConstants.titleData[indexPath.item]
        cell.labelTitle.text = data
        if(indexPath.item == self.titleSelectedIndex){
            cell.labelTitle.textColor = UIColor(red: 78.0/255, green: 139.0/255, blue: 188.0/255, alpha: 1.0)
            cell.viewSelection.backgroundColor = UIColor(red: 78.0/255, green: 139.0/255, blue: 188.0/255, alpha: 1.0)
        }else{
            cell.labelTitle.textColor = UIColor.white
            cell.viewSelection.backgroundColor =  UIColor.white
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.titleSelectedIndex = indexPath.item
        self.collectionViewTitles.reloadData()
    }
    
}
// MARK: Table view Data source

extension MatchDetailsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  20 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Cell = self.tableViewMatchDetails.dequeueReusableCell(withIdentifier: AppConstants.MatchDetailsTableViewCell, for: indexPath) as! MatchDetailsTableViewCell
        
        return Cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // return UITableView.automaticDimension
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
