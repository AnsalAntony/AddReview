//
//  MatchDetailsModel.swift
//  Oddsium
//
//  Created by Ansal Antony on 25/05/22.
//

import Foundation

struct MatchDetailsModel: Codable {
    
    let data: MatchDetailData?
}

struct MatchDetailData: Codable {
    
    let id: Int?
    let name: String?
    let date: String?
    let sport_id: Int?
    let tournament_id: Int?
    let tournament_name: String?
    let tournament_flag_url: String?
    let status: String?
    let live_status: String?
    let progress_bar: String?
    let ht_name: String?
    let ht_id: Int?
    let ht_flag_url: String?
    let at_name: String?
    let at_id: Int?
    let at_flag_url: String?
    let h2h_home_position: String?
    let h2h_home_position_change: String?
    let h2h_away_position: String?
    let h2h_away_position_change: String?
    let h2h_home_wins: String?
    let h2h_away_wins: String?
    let h2h_draws: String?
    let h2h_home_wins_rate: String?
    let h2h_away_wins_rate: String?
    let h2h_draws_rate: String?
    let tournament_start_date: String?
    let Tournament_end_date: String?
    let ht_score: String?
    let at_score: String?
    let score_details: String?
    let odds_format_name: String?
    let odds_format_id: Int?
    let submarket_name: String?
    let submarket_id: Int?
    let reversible: Bool?
    let table_labels: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case date
        case sport_id
        case tournament_id
        case tournament_name
        case tournament_flag_url
        case status
        case live_status
        case progress_bar
        case ht_name
        case ht_id
        case ht_flag_url
        case at_name
        case at_id
        case at_flag_url
        case h2h_home_position
        case h2h_home_position_change
        case h2h_away_position
        case h2h_away_position_change
        case h2h_home_wins
        case h2h_away_wins
        case h2h_draws
        case h2h_home_wins_rate
        case h2h_away_wins_rate
        case h2h_draws_rate
        case tournament_start_date
        case Tournament_end_date
        case ht_score
        case at_score
        case score_details
        case odds_format_name
        case odds_format_id
        case submarket_name
        case submarket_id
        case reversible
        case table_labels
    }
}

