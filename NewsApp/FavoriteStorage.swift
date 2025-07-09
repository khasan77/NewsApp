//
//  FavoriteStorage.swift
//  NewsApp
//
//  Created by Хасан Магомедов on 18.01.2024.
//

import Foundation

final class FavoriteStorage {
    
    static let shared = FavoriteStorage()
    
    static let favoritesChangedNotification = NSNotification.Name("favoritesChanged")
    
    var items: [Article] = []
    
    private init() {}
    
    func handle(_ element: Article) {
        if contains(element) {
            items.removeAll { $0 == element }
        } else {
            items.append(element)
        }
        
        NotificationCenter.default.post(name: FavoriteStorage.favoritesChangedNotification, object: nil)
    }
    
    func contains(_ element: Article) -> Bool {
        items.contains { $0 == element }
    }
}
