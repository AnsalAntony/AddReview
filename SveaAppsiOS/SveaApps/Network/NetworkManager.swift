//
//  NetworkManager.swift
//  SveaApps
//
//  Created by Ansal Antony on 13/02/23.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()

    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }

    func executeAPIRequest(urlString: String, method: HTTPMethod, headers: [String: String] = [:], body: Data? = nil, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers.forEach { (arg) in
            let (field, value) = arg
            request.addValue(value, forHTTPHeaderField: field)
        }
        request.httpBody = body

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(APIServiceError.noData))
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(APIServiceError.invalidHTTPResponseCode))
                return
            }

            completion(.success(data))
        }
        task.resume()
    }
}

enum APIServiceError: Error {
    case noData
    case invalidHTTPResponseCode
}
