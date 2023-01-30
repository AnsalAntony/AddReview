//
//  MatchListModel.swift
//  Oddsium
//
//  Created by Ansal Antony on 25/05/22.
//

import Foundation

struct MatchListModel: Codable {
    let data: DataVal?
}

struct DataVal: Codable {
    let identifier: String?
    let tournament_table: String?
    let tournament_name: String
    let tournament_flag_url: String?
    let tournament_start_date: String?
    let Tournament_end_date: String?
    let table_labels: String?
    var matchsList : [Matchs]
    
    enum CodingKeys: String, CodingKey {
        case identifier
        case tournament_table
        case tournament_name
        case tournament_flag_url
        case tournament_start_date
        case Tournament_end_date
        case table_labels
        case matchsList = "matches"

    }
}

struct Matchs: Codable {
    let id: Int?
    let name: String?
    let date: String?
    let tournament_id: Int?
    let tournament_name: String?
    let tournament_flag_url: String?
    let status: String?
    let live_status: String?
    let ht_name: String?
    let ht_id: Int?
    let ht_flag_url: String?
    let at_name: String?
    let at_id: Int?
    let at_flag_url: String?
    let ht_score: String?
    let at_score: String?
    let score_details: String?
    let sport_id: Int?
    let has_highlights: Bool?
    let has_stream: Bool?
    let reversible: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case date
        case tournament_id
        case tournament_name
        case tournament_flag_url
        case status
        case live_status
        case ht_name
        case ht_id
        case ht_flag_url
        case at_name
        case at_id
        case at_flag_url
        case ht_score
        case at_score
        case score_details
        case sport_id
        case has_highlights, has_stream, reversible
        
    }
    
    
}

