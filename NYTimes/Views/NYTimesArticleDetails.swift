//
//  NYTimesArticleDetails.swift
//  NYTimes
//
//  Created by ALI Naveed on 26/01/2025.
//

import Foundation
import SwiftUI

struct NYTimesArticleDetails: View {
    
    var article: Result
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                NYArticleImageView(urlString: article.media?.first?.mediaMetadata.last?.url ?? "")
                    .accessibilityIdentifier("detailImage")
                    .aspectRatio(contentMode: .fit)
                    .frame(width:200,height:200)
                    .padding(.horizontal,0)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(article.titleArticle ?? "")
                        .font(.title)
                        .padding(.top, 50)
                    HStack {
                        Image(systemName: "calendar.badge.plus")
                        Text(article.publishedDate ?? "")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Text(article.byline ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }.padding(.horizontal,12)
            }
        }
    }
}

struct NYTimesArticleDetails_Previews: PreviewProvider {
    static var previews: some View {
        NYTimesArticleDetails(article: Result.dummyData)
    }
}
