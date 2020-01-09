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
    subscript(position: Int) -> NewsListItem {
        return newsListItems[position]
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
