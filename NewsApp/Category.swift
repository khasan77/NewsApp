//
//  Category.swift
//  NewsApp
//
//  Created by Хасан Магомедов on 20.01.2024.
//

enum Category: CaseIterable {
    case allNews
    case tesla
    case apple
    case google
    case netflix
    
    var displayTitle: String {
        switch self {
        case .allNews:
            return "All news"
        case .tesla:
            return "Tesla"
        case .apple:
            return "Apple"
        case .google:
            return "Google"
        case .netflix:
            return "Netflix"
        }
    }
    
    var requestTitle: String? {
        switch self {
        case .allNews:
            return nil
        case .tesla:
            return "tesla"
        case .apple:
            return "apple"
        case .google:
            return "google"
        case .netflix:
            return "netflix"
        }
    }
}
