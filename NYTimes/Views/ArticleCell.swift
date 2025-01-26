//
//  ArticleCell.swift
//  NYTimes
//
//  Created by ALI Naveed on 25/01/2025.
//

import SwiftUI

struct ArticleCell: View {
    let article: Result
    var body: some View {
        HStack(spacing: 12) {
            NYArticleImageView(urlString: article.media?.first?.mediaMetadata.first?.url ?? "")
                .cornerRadius(8)
                .aspectRatio(contentMode: .fit)
                .frame(height:80)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(article.titleArticle ?? "")
                    .font(.headline)
                    .lineLimit(2)
                
                HStack() {
                    Text(article.byline ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                    HStack {
                        Image(systemName: "calendar.badge.plus")
                        Text(article.publishedDate ?? "")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .listRowInsets(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
        .padding(.horizontal,2)
    }
}

struct ArticleCell_Previews: PreviewProvider {
    static var previews: some View {
        ArticleCell(article: Result.dummyData)
            .previewLayout(.sizeThatFits)
    }
}
