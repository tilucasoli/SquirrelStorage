//
//  UIImageView.swift
//  SquirrelStorage
//
//  Created by David Augusto on 30/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func tintColorTo(color: UIColor) {
        if let image = self.image {
            let templateImage = image.withRenderingMode(.alwaysTemplate)
            self.image = templateImage
            self.tintColor = color
        }
    }
    
    func setImage(url: URL?, placeholder: String) {
        self.image = UIImage(named: placeholder)
        if let imageURL = url {
            ImageFetcher().fetchImage(from: imageURL) { image in
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
    
}
