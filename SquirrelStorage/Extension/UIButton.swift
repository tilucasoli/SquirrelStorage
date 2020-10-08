//
//  UIButton.swift
//  SquirrelStorage
//
//  Created by Rodrigo Matos Aguiar on 30/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setImage(filename: String, placeholder: String, state: UIControl.State) {
        self.setImage(UIImage(named: placeholder), for: state)
        ImageFetcher().fetchImage(filename: filename) { image in
            DispatchQueue.main.async {
                self.setImage(image, for: state)
            }
        }
    }
    
}
