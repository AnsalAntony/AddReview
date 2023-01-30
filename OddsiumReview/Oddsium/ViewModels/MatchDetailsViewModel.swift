//
//  MatchDetailsViewModel.swift
//  Oddsium
//
//  Created by Ansal Antony on 26/05/22.
//

import Foundation
import UIKit

public class MatchDetailsViewModel {
    
    var matchDetails: MatchDetailsModel? = nil
    var matchId = ""
    var timer: Timer?
    var has_stream = false
    
    typealias matchDetailCallBack = (_ status:Bool, _ errorTitle:String, _ errormesg:String) -> Void
    var matchDetailsCallback:matchDetailCallBack?
    
    //MARK:- take match details from Api
    func getGameDetails(){
        OddsiumAPI.sharedInstance.getGameDetails(matchId: self.matchId) { [weak self] MatchDetailsModel, error in
            if error == nil {
                DispatchQueue.main.async {
                    self?.matchDetails = MatchDetailsModel
                    if(self?.matchDetails == nil){
                        self?.matchDetailsCallback?(false, "", AppConstants.noDataAvailable)
                    }else{
                        self?.matchDetailsCallback?(true,"","")
                        self?.matchUpdateTimer()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self?.matchDetailsCallback?(false, "", "")
                }
            }
        }
        
    }
    //MARK:- MatchDetailsCompletionHandler
    func matchDetailCompletionHandler(callBack: @escaping matchDetailCallBack) {
        self.matchDetailsCallback = callBack
    }
    
    //MARK:- Match Update Timer Timer
    func matchUpdateTimer() {
        let formatedDate = self.matchDetails?.data?.date ?? ""
        let datePass = formatedDate.dateTimeFormate(outPutFormate:AppConstants.currentDateFormat)
        let currentDate = Date.getCurrentDate(outPutFormat: AppConstants.currentDateFormat)
        let liveStatus = self.matchDetails?.data?.status ?? ""
        if(currentDate != datePass || liveStatus != "Live"){
            self.removeMatchUpdateTimer()
            return
        }
        if(self.timer == nil){
            print(self.timer as Any)
            self.timer = Timer.scheduledTimer(withTimeInterval: AppConstants.matchListTimer, repeats: true) { (_) in
                self.getGameDetails()
            }
        }
    }
    //MARK:- Remove Match Update Timer Timer
    func removeMatchUpdateTimer() {
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    
    //MARK:- Progress View
    func setupProgressBar(status:String,progressBar:String) -> Double {
        var progressVal = Double(0)
        if(progressBar != ""){
            progressVal = Double(progressBar)!
        }
        
        switch status {
        case "Completed":
            return 0
            
        case "Live":
            return 100 - progressVal
            
        case "Postponed":
            return 100
            
        case "Upcoming":
            return 100
            
        case "":
            return 100
            
        default:
            return 100
        }
    }
    
    //MARK:- handling image urls
    func appendImgBaseUrls(subUrl:String) -> String {
        if(subUrl != "" && subUrl.isEmpty == false){
            return AppConstants.imageBaseUrl + subUrl
        }
        return ""
    }
    
    //MARK:- handling live staus
    func liveStatus(status:String,liveStatus:String) -> String {
        
        switch status {
        case "Completed":
            return "FT"
            
        case "Live":
            return liveStatus
            
        case "Postponed":
            return ""
            
        case "Upcoming":
            return ""
            
        case "":
            return ""
            
        default:
            return ""
        }
    }
    
    
}
