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
            Text("\(article.title)")
        }
    }
}

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
    }
}
