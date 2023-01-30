//
//  AppConstants.swift
//  Oddsium
//
//  Created by Ansal Antony on 24/05/22.
//

import Foundation

struct AppConstants {
    
    // MARK: - BaseUrls
    static let baseURL = "https://psydreus.oddsium.com/"
    static let imageBaseUrl = "http://zeus.oddsium.com/i/"
    
    // MARK: - Endpoints
    static let apiTimeout = 30.0
    static let matchList = "matches?sport=1&countrycode=SE&timezone=europe/stockholm&date="
    static let matchDetails = "match?submarket=1&countrycode=SE&oddstype=1&match="
    
    
    // MARK: - Nib names
       static let MatchScoreTableViewCell = "MatchScoreTableViewCell"
       static let MatchTitleCollectionViewCell = "MatchTitleCollectionViewCell"
       static let MatchDetailsTableViewCell = "MatchDetailsTableViewCell"
       static let WeekCalenderCollectionViewCell = "WeekCalenderCollectionViewCell"
    
    // MARK: - Storyboard names
    static let Match = "Match"
    
    // MARK: - Storyboard identifier
    static let MatchDetailsViewController = "MatchDetailsViewController"
    
    // MARK:- data
    static let titleData = ["Full Time Result","Double Chance","Both Teams Score","Full Time Result"]
    static let weekData = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    
    //MARK: - Messages
    static let PleaseWait = "Please wait"
    static let okay = "OK"
    
    
    // MARK: - Error messages
    static let defaultErrorMessage = "Something went wrong. please check your network connectivity and try again."
    static let couldNotCompleteMessage = "Could not complete request, please try again."
    static let noDataAvailable = "No data available"
    
    // MARK: - Date Formate
    static let inputDateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    static let outPutDateFormat = "E, MMM d, HH:mm"
    static let currentDateFormat = "yyyy-MM-dd"
    
    
    // MARK: - Timer
    static let matchListTimer = 30.0
    static let matchDetailsTimer = 30.0
}
