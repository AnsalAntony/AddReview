//
//  PlaceViewModel.swift
//  SveaApps
//
//  Created by Ansal Antony on 13/02/23.
//

import Foundation

class PlaceViewModel {
    
    var placeList: PlaceListModel?
    let networkService = NetworkService()
    
    func fetchPlaceList(completion: @escaping (Result<PlaceListModel, Error>) -> Void) {
        
        networkService.getPlaceList(records: "50") {  [weak self] (result: Result<PlaceListModel, Error>) in
            switch result {
            case .success(let places):
                // Handleing the array of Place objects here
                self?.placeList = places
                completion(.success(places))
            case .failure(let error):
                // Handleing the error here
                completion(.failure(error))
            }
        }
    }
}
