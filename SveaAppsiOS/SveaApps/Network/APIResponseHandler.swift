//
//  APIResponseHandler.swift
//  SveaApps
//
//  Created by Ansal Antony on 13/02/23.
//

import Foundation


class APIResponseHandler {
    
    func handleResponse<T: Decodable>(data: Data, completion: @escaping (Result<T, Error>) -> Void, type: T.Type) {
        do {
            let decodedObject = try JSONDecoder().decode(type, from: data)
            
            completion(.success(decodedObject))
        } catch {
            completion(.failure(error))
        }
    }
}
