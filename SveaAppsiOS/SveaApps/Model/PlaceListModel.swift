//
//  PlaceListModel.swift
//  SveaApps
//
//  Created by Ansal Antony on 15/02/23.
//

import Foundation


struct PlaceListModel: Codable {
    var place: [PlaceList] = []
}

struct PlaceList: Codable {
    let alias: String?
    let name: String?
    let longitude: Float?
    let latitude: Float?
    let description: String?
    let icon: String?
    let website: String?
    
    
    enum CodingKeys: String, CodingKey {
        case alias
        case name
        case longitude
        case latitude
        case description
        case icon
        case website
        
    }
}

