//
//  NetworkManager.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation

enum HTTPHeaderFields: String {
    case applicationJson = "application/json"
    case applicationXMLurlencoded = "application/xml"
    case applicationContentType = "Content-Type"
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol NetworkManagerProtocol {    
    func apiGETMethod(url: URL) async throws -> Data
}

class NetworkManager: NetworkManagerProtocol {
    fileprivate func checkInternectConnectivity() throws {
        // Check if internet is available
        if !NetworkMonitor.shared.isReachable {
            throw APIError.noNetwork
        }
    }
    
    
    
    func apiGETMethod(url: URL) async throws -> Data {
        try checkInternectConnectivity()
        
        // Set URL parameters
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        request.setValue(HTTPHeaderFields.applicationJson.rawValue,
                         forHTTPHeaderField: HTTPHeaderFields.applicationContentType.rawValue)

        // .ephemeral prevent JSON from caching (They'll store in Ram and nothing on Disk)
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        
        do {
            // Call API to get data
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
