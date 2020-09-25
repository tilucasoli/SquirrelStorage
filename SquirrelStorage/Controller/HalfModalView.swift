//
//  HalfModalView.swift
//  SquirrelStorage
//
//  Created by David Augusto on 24/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class HalfModalView: UIView {
    
    let cardView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
