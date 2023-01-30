//
//  CalendarViewController.swift
//  Oddsium
//
//  Created by Ansal Antony on 23/05/22.
//

import UIKit
import SDWebImage

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var matchScoreTableView: UITableView!
    @IBOutlet weak var collectionViewWeekCalender: UICollectionView!
    var totalDates = [Date]()
    var selectedDate = Date()
    
    
    var viewModelCalendar = CalendarViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.applyGradient(colorArray: [.darkGray, .lightGray])
        self.setupNib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.selectedDate = Date()
        self.setWeekView()
        let dateTody = Date.getCurrentDate(outPutFormat: AppConstants.currentDateFormat)
        self.matchListServiceCall(datePass: dateTody)
    }
    
    func setupNib(){
        let nuibName = AppConstants.MatchScoreTableViewCell
        self.matchScoreTableView.register(UINib(nibName: nuibName, bundle: nil), forCellReuseIdentifier: nuibName)
        self.collectionViewWeekCalender.register(UINib(nibName: AppConstants.WeekCalenderCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: AppConstants.WeekCalenderCollectionViewCell)
    }
    func collectionViewScrolltoIndex(){
        
        var collectionViewSelectedIndex = 0
        for (index, val) in self.totalDates.enumerated(){
            if( val == self.selectedDate){
                collectionViewSelectedIndex = index
            }
        }
        self.collectionViewWeekCalender.scrollToItem(at:IndexPath(item:collectionViewSelectedIndex, section: 0), at: .left, animated: false)
        self.collectionViewWeekCalender.layoutSubviews()
    }
    
    func setWeekView()
    {
        totalDates.removeAll()
        
        var current = viewModelCalendar.sundayForDate(date: selectedDate)
        let nextSunday = viewModelCalendar.addDays(date: current, days: 7)
        
        while (current < nextSunday)
        {
            totalDates.append(current)
            current = viewModelCalendar.addDays(date: current, days: 1)
        }
        self.collectionViewWeekCalender.reloadData()
        self.collectionViewWeekCalender.performBatchUpdates(nil, completion: {
            (result) in
            self.collectionViewScrolltoIndex()
        })
        
    }
    
    func matchListServiceCall(datePass:String) {
        ProgressiveLoader.sharedInstance.showLoader(target: self, title:AppConstants.PleaseWait)
        
        DispatchQueue.main.async {
            
            self.viewModelCalendar.getMatchList(dateVal: datePass)
        }
        
        self.viewModelCalendar.matchListCompletionHandler { [weak self] (status, errorTitle, errormesg) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                if status {
                    ProgressiveLoader.sharedInstance.dismissLoader(target: self)
                    self.matchScoreTableView.reloadData()
                } else {
                    ProgressiveLoader.sharedInstance.dismissLoader(target: self)
                    self.alertPresent(title: errorTitle, message: errormesg)
                }
            }
        }
    }
}



// MARK: Table view Data source

extension CalendarViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.viewModelCalendar.matchLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Cell = self.matchScoreTableView.dequeueReusableCell(withIdentifier: AppConstants.MatchScoreTableViewCell, for: indexPath) as! MatchScoreTableViewCell
        let matchs = self.viewModelCalendar.matchLists[indexPath.row]
        let formatedDate = matchs.date ?? ""
        Cell.labelDateTime.text = formatedDate.dateTimeFormate(outPutFormate:AppConstants.outPutDateFormat)
        let leagueImgUrl = viewModelCalendar.appendImgUrls(subUrl:matchs.tournament_flag_url ?? "")
        Cell.imageViewFlag.sd_setImage(with: URL(string: leagueImgUrl), placeholderImage: UIImage(named: "flag.png"))
        let ht_flag_Url = viewModelCalendar.appendImgUrls(subUrl:matchs.ht_flag_url ?? "")
        Cell.imageViewLogo.sd_setImage(with: URL(string: ht_flag_Url), placeholderImage: UIImage(named: "flag.png"))
        let at_flag_Url = viewModelCalendar.appendImgUrls(subUrl:matchs.at_flag_url ?? "")
        Cell.imageViewLogo2.sd_setImage(with: URL(string: at_flag_Url), placeholderImage: UIImage(named: "flag.png"))
        Cell.labelLeague.text = matchs.tournament_name ?? ""
        Cell.labelTeamName1.text = matchs.ht_name ?? ""
        Cell.labelTeamName2.text = matchs.at_name ?? ""
        Cell.labelScore.text = "0" + " - " + "0"
        if let htScore = matchs.ht_score, let atScore =  matchs.at_score{
            Cell.labelScore.text = htScore + " - " + atScore
        }
        Cell.labelStatus.text = viewModelCalendar.liveStatus(status: matchs.status ?? "", liveStatus: matchs.live_status ?? "")
        Cell.viewStatusIcon.isHidden = viewModelCalendar.showStatusIcon(status: matchs.status ?? "")
        return Cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // return UITableView.automaticDimension
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = UIStoryboard(name:AppConstants.Match, bundle:nil).instantiateViewController(withIdentifier:AppConstants.MatchDetailsViewController) as! MatchDetailsViewController
        let match = self.viewModelCalendar.matchLists[indexPath.row]
        detailVC.matchDetailViewModel.matchId = String(match.id ?? 0)
        detailVC.matchDetailViewModel.has_stream = match.has_stream ?? false
        self.navigationController?.show(detailVC, sender: self)
        
    }
    
}
// MARK: collectin view Data source
extension CalendarViewController:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.totalDates.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 118);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : WeekCalenderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.WeekCalenderCollectionViewCell, for: indexPath) as! WeekCalenderCollectionViewCell
        let date = totalDates[indexPath.item]
        let week = AppConstants.weekData[indexPath.row]
        cell.labelDate.text = viewModelCalendar.dayOfMonth(date: date)
        cell.labelWeek.text = week
        
        if(date == selectedDate){
            cell.ViewSelection.backgroundColor = UIColor(red: 78.0/255, green: 141.0/255, blue: 189.0/255, alpha: 1.0)
            cell.viewRound.backgroundColor = UIColor(red: 78.0/255, green: 141.0/255, blue: 189.0/255, alpha: 1.0)
        }
        else{
            cell.ViewSelection.backgroundColor = UIColor.clear
            cell.viewRound.backgroundColor = UIColor(red: 104.0/255, green: 103.0/255, blue: 108.0/255, alpha: 1.0)
        }
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.selectedDate = totalDates[indexPath.item]
        collectionView.reloadData()
        let dateSelected =  self.viewModelCalendar.selectedDate(date: self.selectedDate)
        self.matchListServiceCall(datePass: dateSelected)
    }
}
