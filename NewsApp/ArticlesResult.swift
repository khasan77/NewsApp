//  ArticlesResult.swift
//  NewsApp
//  Created by Хасан Магомедов on 31.12.2023.

struct ArticlesResult: Decodable {
    let status: String
    let totalResults: Int
    let articles: [ArticleResult]
}
