//
//  HittaAPI.swift
//  iOSHittaApp
//
//  Created by Ansal Antony on 26/09/22.
//

import CoreLocation
import Foundation
import UIKit


final class OddsiumAPI {
    static let sharedInstance = OddsiumAPI()
    
    private var networkService: NetworkService {
        NetworkManager.sharedInstance
    }
    
    private init() {}
    
    private func executeRequest(urlString: String, parameters: [String: Any]? = nil, method: RequestMethod? = .get, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        guard let request = URLRequest.prepareURLRequest(urlString: urlString, parameters: parameters, method: method) else {
            return
        }
        
        networkService.executeRequest(request) { data, error in
            completion(data, error)
        }
    }
    
    private func executePostRequest(urlString: String, parameters: [String: Any]? = nil, headers: [String: String]? = nil, method: RequestMethod? = .post, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        guard let request = URLRequest.prepareURLRequest(urlString: urlString, parameters: parameters, headers: headers, method: method) else {
            return
        }
        
        networkService.executeRequest(request) { data, error in
            completion(data, error)
        }
    }
    
    
    
    //MARK: get match list
    func getGameList(dateVal: String,with completion: @escaping (MatchListModel?, Error?) -> Void) {
        
        let urlString = AppConstants.baseURL + AppConstants.matchList + dateVal
        
        executeRequest(urlString: urlString) { data, error in
            if let error = error {
                completion(nil, error)
            } else {
                guard let data = data else {
                    return
                }
                let response = data.decodeTo(MatchListModel.self)
                completion(response, nil)
            }
        }
        
    }
    
    //MARK: get match details
    func getGameDetails(matchId: String,with completion: @escaping (MatchDetailsModel?, Error?) -> Void) {
        let urlString = AppConstants.baseURL + AppConstants.matchDetails + matchId
        executeRequest(urlString: urlString) { data, error in
            if let error = error {
                completion(nil, error)
            } else {
                guard let data = data else {
                    return
                }
                let response = data.decodeTo(MatchDetailsModel.self)
                completion(response, nil)
            }
        }
    }
    
    
}
