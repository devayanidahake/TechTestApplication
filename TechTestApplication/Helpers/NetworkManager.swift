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
    
    private init() {
        
    }
       
    
    func GET(url: String, httpHeader: HTTPHeaderFields, complete: @escaping (Bool, Data?, NetworkError?) -> ()) {
        
        if !NetworkMonitor.shared.isReachable {
            print("Error: internet is not working")
            complete(false, nil, NetworkError.noNetwork)
            return
        }
        guard var components = URLComponents(string: url) else {
            print("Error: cannot create URLCompontents")
            return
        }
//        components.queryItems = params.map { key, value in
//            URLQueryItem(name: key, value: value)
//        }

        guard let url = components.url else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        switch httpHeader {
        case .application_json:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .application_x_www_form_urlencoded:
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        case .none: break
        }

        
        // .ephemeral prevent JSON from caching (They'll store in Ram and nothing on Disk)
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: problem calling GET")
                print(error!)
                complete(false, nil, NetworkError.unknown)
                return
            }
            guard let data = data else {
                print("Error: did not receive data")
                complete(false, nil,NetworkError.responseError)
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                complete(false, nil, NetworkError.unknown)
                return
            }
            complete(true, data, nil)
        }.resume()
    }
}



enum NetworkError: Error {
    case noNetwork
    case invalidURL
    case responseError
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        case .noNetwork:
            return NSLocalizedString("Please check your internet connection", comment: "Unknown error")
        }
    }
}



