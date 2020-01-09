//
//  NewsFeedModel.swift
//  NewsApp
//
//  Created by Mykhailo Bondarenko on 09.01.2020.
//  Copyright © 2020 Mykhailo Bondarenko. All rights reserved.
//

import Foundation

class NewsFeed: ObservableObject, RandomAccessCollection {
    
    
    typealias Element = NewsListItem
    @Published var newsListItems = [NewsListItem]()
    
    var startIndex: Int {
        newsListItems.startIndex
    }
    var endIndex: Int {
        newsListItems.startIndex
    }
    
    var urlBase = "https://newsapi.org/v2/everything?q=apple&apiKey=31095a21e4cf49589631c1d069c2309c&language=en&page=1"
    
    init() {
        loadMoreArticles()
    }
    
    subscript(position: Int) -> NewsListItem {
        return newsListItems[position]
    }
    
    func loadMoreArticles() {
        let url = URL(string: urlBase)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: parseArticlesFromResponse(data:response:error:))
        task.resume()
    }
    
    func parseArticlesFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error\(error!)")
            return
        }
        guard let data = data else {
            print("No data found")
            return
        }
        
        let newArticles = parseArticlesFromData(data: data)
        DispatchQueue.main.async {
            self.newsListItems.append(contentsOf: newArticles)
        }
    }
    
    func parseArticlesFromData(data: Data) -> [NewsListItem] {
        let jsonObject = try! JSONSerialization.jsonObject(with: data)
        let topLevelMap = jsonObject as! [String: Any]
        guard topLevelMap["status"] as? String == "ok" else {
            print("Status returned was not OK")
            return []
        }
        guard let jsonArticles = topLevelMap["articles"] as? [[String: Any]] else {
            print("No articles found")
            return []
        }
        var newArticles = [NewsListItem]()
        for jsonArticle in jsonArticles {
            guard let title = jsonArticle["title"] as? String else {
                continue
            }
            guard let author = jsonArticle["author"] as? String else {
                continue
            }
            newArticles.append(NewsListItem(title: title, author: author))
        }
        return newArticles
    }
}

class NewsListItem: Identifiable {
    var uuid = UUID()
    var author: String
    var title: String
    
    init(title: String, author: String) {
        self.title = title
        self.author = author
    }
}
