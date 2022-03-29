//
//  NetworkManager.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation

enum HTTPHeaderFields: String {
    case application_json = "application/json"
    case application_x_www_form_urlencoded = "application/xml"
    case application_content_type = "Content-Type"
    case none
}

enum HTTPMethod:String {
    case GET = "GET"
    case POST = "POST"
}

protocol NetworkManagerProtocol {
    
    func apiGETMethod(url: String) async throws -> Data
    
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func apiGETMethod(url: String) async throws -> Data {
        //Check if internet is available
        if !NetworkMonitor.shared.isReachable {
            throw APIError.noNetwork
        }
        //Check if api url is correct
        guard let components = URLComponents(string: url) else {
            throw APIError.invalidURL
        }
        
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        //Set URL parameters
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        
        request.setValue(HTTPHeaderFields.application_json.rawValue, forHTTPHeaderField: HTTPHeaderFields.application_content_type.rawValue)

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




