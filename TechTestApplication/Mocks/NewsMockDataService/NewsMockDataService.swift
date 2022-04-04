//
//  NewsMockService.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 25/03/22.
//

import Foundation

enum ResponseType {
    case success
    case error
}

class NewsMockDataService: NewsDataServiceProtocol {
    var responseType: ResponseType = .success
    
    func getNewsData(api: NewsApi) async throws -> NewsArray {
        switch responseType {
        case .success:
            if !(NetworkMonitor.shared.isReachable) {
                throw APIError.noNetwork
            }
            if api == .invalid {
                throw APIError.unknown
            }
            do {
                let newsArray = try StubGenerator.stubNews()
                return newsArray
            } catch {
                throw error
            }
            
        case .error :
            throw APIError.responseError
        }
    }
}
