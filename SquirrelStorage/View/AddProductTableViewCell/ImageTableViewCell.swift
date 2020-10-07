//
//  AddProductTableViewCell.swift
//  SquirrelStorage
//
//  Created by Lucas Fernandes on 24/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit
import PhotosUI

protocol imagePickerDelegate: AnyObject {
    func presentImagePicker(imgPickerController: UIImagePickerController)
}

extension imagePickerDelegate where Self: UIViewController {
    func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        self.dismiss(animated: flag, completion: completion)
    }
}

class ImageTableViewCell: UITableViewCell {

    weak var delegate: imagePickerDelegate?
    
    let productImageButton: UIButton = {
        let imageBtn = UIButton(type: .custom)
        imageBtn.backgroundColor = .purpleSS
        imageBtn.tintColor = .background
        let scaleConfig = UIImage.SymbolConfiguration(pointSize: 27)
        imageBtn.setImage(UIImage(systemName: "camera.fill", withConfiguration: scaleConfig), for: .normal)
        //imageBtn.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        imageBtn.imageView?.contentMode = .scaleAspectFill
        imageBtn.layer.cornerRadius = 19
        
        return imageBtn
    }()
    
    @objc func presentImagePicker() {
        showImagePickerController()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(productImageButton)
        productImageButton.addTarget(self, action: #selector(presentImagePicker), for: .touchUpInside)
        setProductImageConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProductImageConstraints() {
        productImageButton.translatesAutoresizingMaskIntoConstraints                                     = false
        
        productImageButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                     = true
        productImageButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                     = true
        productImageButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.57).isActive     = true
        productImageButton.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.57).isActive      = true
//        productImageButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension ImageTableViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showImagePickerController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        delegate?.presentImagePicker(imgPickerController: imagePickerController)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let edited = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            productImageButton.setImage(edited, for: .normal)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            productImageButton.setImage(originalImage, for: .normal)
        }
//        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
//            imageURL = url
//        }
        productImageButton.imageView?.layer.cornerRadius = 19
        if let delegateVC = delegate as? UIViewController {
            delegateVC.dismiss(animated: true, completion: nil)
        }
    }
}
