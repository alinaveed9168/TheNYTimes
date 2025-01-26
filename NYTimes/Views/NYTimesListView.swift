//
//  NYTimesListView.swift
//  NYTimes
//
//  Created by ALI Naveed on 23/01/2025.
//

import SwiftUI

struct NYTimesListView: View {
    
    @StateObject var viewModel: ArticleViewModel
    
    // Dependency injection through initializer
    init(viewModel: ArticleViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .failed(error: let error):
                    ErrorView(error: error) {
                        self.viewModel.getArticles()
                    }
                case .success(content: let content):
                    List(content) { article in
                        NavigationLink(destination: NYTimesArticleDetails(article: article)) {
                            ArticleCell(article: article)
                     }
                    }
                    .listStyle(.inset)
                }
            }
            .navigationTitle("NYTimes")
        }
        .onAppear {
            self.viewModel.getArticles()
        }
    }
}


struct NYTimesListView_Previews: PreviewProvider {
    static var previews: some View {
        NYTimesListView(viewModel: ArticleViewModel(service: NetworkManager()))
    }
}
