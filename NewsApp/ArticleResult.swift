//
//  Article.swift
//  NewsApp
//
//  Created by Хасан Магомедов on 28.12.2023.
//

import UIKit

struct ArticleResult: Decodable {
    let author: String?
    let title: String?
    let description: String?
    let content: String?
    let urlToImage: URL?
    let url: URL?
    let publishedAt: String?
}
