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

    func fetchImage(filename: String, completion: @escaping (UIImage) -> Void) {
        var image = UIImage()
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let imgURL = url.appendingPathComponent(filename).appendingPathExtension("jpeg")
        //print(imgURL)
        if let cachedImage = ImageFetcher.imageCache.object(forKey: imgURL.absoluteString as NSString) {
            image = cachedImage
            completion(image)
        } else {
            let urlRequest = URLRequest(url: imgURL)
            URLSession.shared.dataTask(with: urlRequest) { data, _, _ in
                guard let data = data else { return }
                image = UIImage(data: data)!
                completion(image)
            }.resume()
        }
    }
    
    func saveImage(image: UIImage) -> String {
        let fileManager = FileManager.default
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filename = UUID().uuidString
        let fileURL = url.appendingPathComponent(filename).appendingPathExtension("jpeg")
        if let data = image.jpegData(compressionQuality: 1) {
            fileManager.createFile(atPath: fileURL.path, contents: data, attributes: nil)
        }
        return filename
    }

}
