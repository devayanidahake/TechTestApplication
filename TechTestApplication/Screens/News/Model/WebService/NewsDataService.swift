//
//  NewsDataService.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation

enum NewsApi {
    case list
    case invalid
    var apiURL: String {
        switch self {
        case .list:
            return Constants.URLs.baseURL + Constants.URLs.newsListEndpoints
        case .invalid:
            return Constants.URLs.baseURL
        }        
    }
}

protocol NewsDataServiceProtocol {
    func getNewsData(api: NewsApi) async throws -> [News]
}

class NewsDataService: NewsDataServiceProtocol {
    private var networkManager: NetworkManagerProtocol
    
    init(withNetworkManager: NetworkManagerProtocol) {
        self.networkManager = withNetworkManager
    }
    
    
    func getNewsData(api: NewsApi) async throws -> [News] {
        do {
            // Check if api url is correct
            let url = try createNewsURL(api: api)
            let responseData = try await self.networkManager.initiateServiceRequest(url: url)
            let newsDictData = try self.parseServerResponseData(serverResponseData: responseData)
            return newsDictData.newsArray
        } catch {
            throw error
        }
    }
    
    private func createNewsURL(api: NewsApi) throws -> URL {
        guard let components = URLComponents(string: api.apiURL) else {
            throw APIError.invalidURL
        }
        
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        return url
    }
    
    private func parseServerResponseData(serverResponseData: Data?) throws -> ServerResponse {
        guard let data = serverResponseData
        else {  throw APIError.responseError }
        do {
            let newsDict = try JSONDecoder().decode(ServerResponse.self, from: data)
            return newsDict
        } catch {
            throw APIError.responseError
        }
    }
}
