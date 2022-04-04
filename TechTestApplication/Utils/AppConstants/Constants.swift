//
//  Constants.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 28/03/22.
//

import Foundation
struct Constants {
    struct Texts {
        static let newsListTitle = "News"
        static let newsDetailTitle = "News-Details"
        static let alertOkTitle = "Ok"
        static let alertCancelTitle = "Cancel"
        static let alertQuitTitle = "Quit"
    }
    
    struct URLs {
        static let baseURL = "https://inshortsapi.vercel.app"
        static let newsListEndpoints = "/news?category=science"
    }
    
    struct StoryboardXIBNames {
        static let main = "Main"
        static let newsViewController = "NewsViewController"
        static let newsDetailViewController = "NewsDetailViewController"
    }
    
    struct Value {
        static let tableRowEstimatedHeight = 90.0
    }
  
    struct ErrorMessages {
        static let xibNotFound = "xib does not exists"
        static let invalidURL = "Invalid URL"
        static let invalidResponse = "Invalid response"
        static let unknownError = "Unknown error"
        static let noInternetConnection = "No internet connection"
        static let noError = "No Error"
        static let jailbrokenDevice = "This Device is JailBroken.Please quit the application."
    }
    
    struct Image {
        static let placeholderImage = "placeholderImage.png"
    }
}
