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
    
    func apiGETMethod(url: String) async throws -> Data {
        
        if !NetworkMonitor.shared.isReachable {
            throw APIError.noNetwork
        }
        guard let components = URLComponents(string: url) else {
            throw APIError.invalidURL
        }
        
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // .ephemeral prevent JSON from caching (They'll store in Ram and nothing on Disk)
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        
        do {
            let (dataObj, response) = try await session.data(for: request, delegate: nil)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw APIError.responseError
            }
           
           return dataObj
        }catch{
            throw APIError.unknown
        }
    }
    
}




