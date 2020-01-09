//
//  NewsFeedView.swift
//  NewsApp
//
//  Created by Mykhailo Bondarenko on 09.01.2020.
//  Copyright © 2020 Mykhailo Bondarenko. All rights reserved.
//

import SwiftUI

struct NewsFeedView: View {
    @ObservedObject var newsFeed = NewsFeed()
    
    var body: some View {
        List(newsFeed) { (article: NewsListItem) in
            NewsListItemView(article: article)
        }
    }
}

struct NewsListItemView: View {
    var article: NewsListItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(article.title)").font(.headline)
            Text("\(article.author)").font(.subheadline)
        }.padding()
    }
}

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
    }
}
