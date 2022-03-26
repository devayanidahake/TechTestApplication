//
//  NetworkManager.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation
enum HTTPHeaderFields {
    case application_json
    case application_x_www_form_urlencoded
    case none
}

enum Endpoint: String {
    case flights
    case details
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func apiGETMethod(url: String, httpHeader: HTTPHeaderFields, complete: @escaping (Bool, Data?, APIError?) -> ()) {
        
        if !NetworkMonitor.shared.isReachable {
            complete(false, nil, APIError.noNetwork)
            return
        }
        guard let components = URLComponents(string: url) else {
            complete(false, nil, APIError.invalidURL)
            return
        }
        
        guard let url = components.url else {
            complete(false, nil, APIError.invalidURL)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // .ephemeral prevent JSON from caching (They'll store in Ram and nothing on Disk)
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                complete(false, nil, APIError.unknown)
                return
            }
            guard let data = data else {
                complete(false, nil,APIError.responseError)
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                complete(false, nil, APIError.unknown)
                return
            }
            complete(true, data, nil)
        }.resume()
    }
}

enum APIError: Error {
    case noNetwork
    case invalidURL
    case responseError
    case unknown
    case noError
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .responseError:
            return "Invalid response"
        case .unknown:
            return "Unknown error"
        case .noNetwork:
            return "No internet connection"
        case .noError:
            return "No Error"
        }
    }
}



