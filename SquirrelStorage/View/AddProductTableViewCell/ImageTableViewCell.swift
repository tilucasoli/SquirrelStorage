//
//  AddProductTableViewCell.swift
//  SquirrelStorage
//
//  Created by Lucas Fernandes on 24/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    let productImageButton: UIButton = {
        let imageBtn = UIButton(type: .custom)
        imageBtn.backgroundColor = .purpleSS
        imageBtn.tintColor = .background
        let scaleConfig = UIImage.SymbolConfiguration(pointSize: 27)
        imageBtn.setImage(UIImage(systemName: "camera.fill", withConfiguration: scaleConfig), for: .normal)
        //imageBtn.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        imageBtn.imageView?.contentMode = .scaleAspectFill
        imageBtn.layer.cornerRadius = 8
        
        return imageBtn
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(productImageButton)
        
        setProductImageConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProductImageConstraints() {
        productImageButton.translatesAutoresizingMaskIntoConstraints                                                      = false
        productImageButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 80).isActive            = true
        productImageButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                      = true
        productImageButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive                       = true
        productImageButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.229).isActive                                                                                                                                    = true
//        productImageButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}

