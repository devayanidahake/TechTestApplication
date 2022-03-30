//
//  MockNetworkManager.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 30/03/22.
//

import Foundation

class MockNetworkManager: NetworkManagerProtocol {
    
    func apiGETMethod(url: URL) async throws -> Data {
        guard url.isFileURL == true else{
            throw APIError.responseError
        }
        return Data()
    }
    
    
}

