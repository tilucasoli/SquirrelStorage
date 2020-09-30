//
//  ImageFetcher.swift
//  SquirrelStorage
//
//  Created by Rodrigo Matos Aguiar on 30/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class ImageFetcher {

    private static let imageCache = NSCache<NSString, UIImage>()

    func fetchImage(from imgURL: URL, completion: @escaping (UIImage) -> Void) {
        var image = UIImage()

        if let cachedImage = ImageFetcher.imageCache.object(forKey: imgURL.absoluteString as NSString) {
            image = cachedImage
            completion(image)
        } else {
            let urlRequest = URLRequest(url: imgURL)
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data else { return }
                image = UIImage(data: data)!
                completion(image)
            }.resume()
        }
    }

}
