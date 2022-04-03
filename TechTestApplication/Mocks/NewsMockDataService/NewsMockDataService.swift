//
//  NewsMockService.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 25/03/22.
//

import Foundation

class NewsMockDataService: NewsDataServiceProtocol {
    func getNewsData(api: NewsApi) async throws -> NewsArray {
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
    }
}
