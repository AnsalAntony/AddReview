//
//  NetworkService.swift
//  SveaApps
//
//  Created by Ansal Antony on 13/02/23.
//

import Foundation


class NetworkService {
    
    //static let shared = NetworkService()
    
    let apiResponseHandler = APIResponseHandler()
    
    func getPlaceList<T: Decodable>(records: String, completion: @escaping (Result<T, Error>) -> Void) {
        let placeListUrl = APIConstants.baseUrl + APIConstants.Endpoints.getPlaceList + records
        NetworkManager.shared.executeAPIRequest(urlString: placeListUrl, method: .get) { (result) in
            switch result {
            case .success(let data):
                self.apiResponseHandler.handleResponse(data: data, completion: completion, type: T.self)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
}
