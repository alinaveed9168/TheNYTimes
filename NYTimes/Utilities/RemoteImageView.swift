//
//  RemoteImageView.swift
//  NYTimes
//
//  Created by ALI Naveed on 25/01/2025.
//

import SwiftUI
import Combine
import UIKit

struct NYArticleImageView: View {
    @StateObject private var imageLoader = ImageLoader()
    var urlString: String
    
    var body: some View {
        RemoteImageView(imageLoader: imageLoader)
            .onAppear {
                guard let validURL = URL(string: urlString) else {
                    return
                }
                imageLoader.loadImage(from: validURL)
            }
    }
}

struct RemoteImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    var placeholder: Image = Image("NYTimesPlaceholder")
    
    var body: some View {
        if let uiImage = imageLoader.image {
            Image(uiImage: uiImage)
        } else {
            placeholder
                .resizable()
        }
    }
}

final class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil
    private var cancellable: AnyCancellable?
    
    func loadImage(from url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
}
