//
//  UIButton.swift
//  SquirrelStorage
//
//  Created by Rodrigo Matos Aguiar on 30/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setImage(url: URL?, placeholder: String, state: UIControl.State) {
        self.setImage(UIImage(named: placeholder), for: state)
        if let imageURL = url {
            ImageFetcher().fetchImage(from: imageURL) { image in
                DispatchQueue.main.async {
                    self.setImage(image, for: state)
                }
            }
        }
    }
    
}
