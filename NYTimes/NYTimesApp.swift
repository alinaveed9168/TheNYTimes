//
//  NYTimesApp.swift
//  NYTimes
//
//  Created by ALI Naveed on 23/01/2025.
//

import SwiftUI

@main
struct NYTimesApp: App {
    var body: some Scene {
        WindowGroup {
            if CommandLine.arguments.contains("-UITest_ErrorView") {
                ErrorView(error: NetworkError.decodeError) {
                    print("Retry button tapped")
                }
            } else if CommandLine.arguments.contains("-UITest_DetailView") {
                NYTimesArticleDetails(article: Result.dummyData)
            } else {
                // Main app entry
                let service = NetworkManager()
                let viewModel = ArticleViewModel(service: service)
                NYTimesListView(viewModel: viewModel)
            }
        }
    }
}
