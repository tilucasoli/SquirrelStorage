//
//  UITextField.swift
//  SquirrelStorage
//
//  Created by Rodrigo Matos Aguiar on 30/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

extension UITextField {

    func underlined() {

        self.layer.backgroundColor = UIColor.background.cgColor

        self.layer.masksToBounds = false

        self.layer.shadowColor = UIColor.gray.cgColor

        self.layer.shadowOffset = CGSize(width: 0, height: 2)

        self.layer.shadowOpacity = 1

        self.layer.shadowRadius = 0
    }
}
