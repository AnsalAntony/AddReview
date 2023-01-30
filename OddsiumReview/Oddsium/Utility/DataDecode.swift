//
//  DataDecode.swift
//  iOSHittaApp
//
//  Created by Ansal Antony on 26/09/22.
//

import Foundation
import UIKit


extension Data {
    func decodeTo<T: Decodable>(_ type: T.Type) -> T? {
        do {
            let response = try JSONDecoder().decode(type, from: self)
            return response
        } catch let jsonError {
            print("Json Decoding Error",jsonError)
            return nil
        }
    }
}

