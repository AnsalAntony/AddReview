//
//  APIConstants.swift
//  SveaApps
//
//  Created by Ansal Antony on 13/02/23.
//

import Foundation

struct APIConstants {
    static let apiVesion = "1.0"
    
    static let baseUrl = "https://secure.closepayment.com/close-admin/" + apiVesion

    struct Endpoints {
        static let appId = "50"
        static let getPlaceList = "/place/meappid?meAppId=" + appId + "&records="
    }
}
