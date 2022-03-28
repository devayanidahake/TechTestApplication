//
//  Constants.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 28/03/22.
//

import Foundation
struct Constants {
    struct Titles{
        static let newsListTitle = "News"
        static let newsDetailTitle = "News-Details"
    }
    
    struct URLs{
        static let baseURL = "https://inshortsapi.vercel.app"
        static let newsListEndpoints = "/news?category=science"
    }
    
    struct StoryboardXIBNames{
        static let main = "Main"
        static let newsDetailViewController = "NewsDetailViewController"
    }
}
