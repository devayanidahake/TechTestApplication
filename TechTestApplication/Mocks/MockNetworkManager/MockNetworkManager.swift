//
//  MockNetworkManager.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 30/03/22.
//

import Foundation

class MockNetworkManager: NetworkManagerProtocol {    
    func apiGETMethod(url: URL) async throws -> Data {
        do{
            let responseData = try StubGenerator.stubResponseData()
            return responseData
        }
        catch
        {
            throw APIError.responseError
        }
    }
}
