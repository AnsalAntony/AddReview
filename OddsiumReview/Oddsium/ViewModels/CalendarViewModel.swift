//
//  CalendarViewModel.swift
//  Oddsium
//
//  Created by Ansal Antony on 25/05/22.
//

import Foundation
import UIKit

public class CalendarViewModel {
    
    var matchListData: MatchListModel? = nil
    var matchLists: [Matchs] = []
    var timer: Timer?
    
    let calendar = Calendar.current
    
    
    typealias matchListCallBack = (_ status:Bool, _ errorTitle:String, _ errormesg:String) -> Void
    var matchCallback:matchListCallBack?
    
    //MARK:- take match list from Api
    func getMatchList(dateVal:String){
        
        OddsiumAPI.sharedInstance.getGameList(dateVal: dateVal) { [weak self] MatchListModel, error in
            if error == nil {
                DispatchQueue.main.async {
                    self?.matchListData = MatchListModel
                    if(self?.matchListData?.data?.matchsList.isEmpty == true){
                        self?.matchCallback?(false, "", AppConstants.noDataAvailable)
                    }else{
                        self?.matchLists = self?.matchListData?.data?.matchsList ?? []
                        self?.matchCallback?(true,"","")
                        //self.matchUpdateTimer(datePass:dateVal)
                    }
                }
            }else{
                self?.matchCallback?(false, "", "")
            }
        }
        
    }
    
    //MARK:- MatchListCompletionHandler
    func matchListCompletionHandler(callBack: @escaping matchListCallBack) {
        self.matchCallback = callBack
    }
    
    
    func addDays(date: Date, days: Int) -> Date
    {
        return calendar.date(byAdding: .day, value: days, to: date)!
    }
    
    func sundayForDate(date: Date) -> Date
    {
        var current = date
        let oneWeekAgo = addDays(date: current, days: -7)
        
        while(current > oneWeekAgo)
        {
            let currentWeekDay = calendar.dateComponents([.weekday], from: current).weekday
            if(currentWeekDay == 1)
            {
                return current
            }
            current = addDays(date: current, days: -1)
        }
        return current
    }
    func dayOfMonth(date: Date) -> String
    {
        let components = calendar.dateComponents([.day, .month], from: date)
        let dateStr = String(components.day!)
        let monthInt = components.month!
        let monthStr = Calendar.current.monthSymbols[monthInt-1]
        let finalDate = monthStr + " " + dateStr
        
        return finalDate
        
    }
    
    func selectedDate(date: Date) -> String
    {
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        var dateStr = String(components.day!)
        var monthStr = String(components.month!)
        let yearStr = String(components.year!)
        if(dateStr.count == 1){
            dateStr = "0"+dateStr
        }
        if(monthStr.count == 1){
            monthStr = "0"+monthStr
        }
        
        let finalDate = yearStr + "-" + monthStr + "-" + dateStr
        
        return finalDate
    }
    
    
    
    //    //MARK:- Match Update Timer Timer
    //    func matchUpdateTimer(datePass:String) {
    //        let currentDate = Date.getCurrentDate(outPutFormat: AppConstants.currentDateFormat)
    //        if(currentDate != datePass){
    //            self.removeMatchUpdateTimer()
    //            return
    //        }
    //        if(self.timer == nil){
    //            self.timer = Timer.scheduledTimer(withTimeInterval: AppConstants.matchListTimer, repeats: true) { (_) in
    //                self.getMatchList(dateVal:currentDate)
    //            }
    //        }
    //    }
    //    //MARK:- Remove Match Update Timer Timer
    //    func removeMatchUpdateTimer() {
    //        if self.timer != nil {
    //            self.timer?.invalidate()
    //            self.timer = nil
    //        }
    //    }
    //
    func liveStatus(status: String,liveStatus:String) -> String {
        if(status == "Live"){
            return liveStatus
        }
        return status
    }
    
    //MARK:- hiding and showing staus simbol
    func showStatusIcon(status:String) -> Bool {
        if(status == "Completed" || status == "Postponed" || status == "Upcoming" || status == ""){
            return true
        }
        return false
    }
    
    //MARK:- handling image urls
    func appendImgUrls(subUrl:String) -> String {
        if(subUrl != "" && subUrl.isEmpty == false){
            return AppConstants.imageBaseUrl + subUrl
        }
        return ""
    }
}
