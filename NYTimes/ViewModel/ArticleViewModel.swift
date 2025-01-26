//
//  ArticleViewModel.swift
//  NYTimes
//
//  Created by ALI Naveed on 26/01/2025.
//

import Foundation
import Combine

protocol ArticleViewModelProtocol: ObservableObject {
    func getArticles ()
}

enum ResultState {
    case loading
    case failed(error: Error)
    case success(content: [Result])
}

class ArticleViewModel: ObservableObject, ArticleViewModelProtocol {
    
    private var cancellables = Set<AnyCancellable>()
    @Published var resultList = [Result]()
    @Published private(set) var state: ResultState = .loading

    private let service: NetworkManagerProtocol
    
    init(service: NetworkManagerProtocol) {
        self.service = service
    }
    
    func getArticles() {
        
        self.state = .loading
        
        let cancellable = service.getData(endpoint: ArticleAPI(endpoint: .topArticle), type: Article.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Finished successfully")
                    self.state = .success(content: self.resultList)
                case .failure(let error):
                    print("Error: \(error)")
                    self.state = .failed(error: error)
                }
            }, receiveValue: { resultList in
                print("Fetched Articles: \(resultList)")
                self.resultList = resultList.results
            })
        self.cancellables.insert(cancellable)
    }
}
