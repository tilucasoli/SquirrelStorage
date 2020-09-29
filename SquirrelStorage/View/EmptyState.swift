//
//  EmptyState.swift
//  SquirrelStorage
//
//  Created by Lucas Oliveira on 28/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class EmptyState: UIView {
    let roundedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.purpleSS.withAlphaComponent(0.1)
        view.layer.cornerRadius = 71
        return view
    }()
    
    let illustration: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "illustrationEmptyState")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "Ainda não a nada aqui!"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .largeTitle
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Seu estoque está vazio, Adicione seus produtos clicando em +"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .largeTitle
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRoundedView()
        setupIllustration()
        setupTitle()
        setupDescription()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupRoundedView() {
        addSubview(roundedView)
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            roundedView.topAnchor.constraint(equalTo: topAnchor),
            roundedView.centerXAnchor.constraint(equalTo: centerXAnchor),
            roundedView.heightAnchor.constraint(equalToConstant: 142),
            roundedView.widthAnchor.constraint(equalToConstant: 142)
        ])
    }
    
    func setupIllustration() {
        addSubview(illustration)
        illustration.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            illustration.centerXAnchor.constraint(equalTo: roundedView.centerXAnchor),
            illustration.centerYAnchor.constraint(equalTo: roundedView.centerYAnchor),
            illustration.heightAnchor.constraint(equalToConstant: 47)
        ])
    }
    
    func setupTitle() {
        addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: 30),
            title.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setupDescription() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 9),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 274)
        ])
    }
}
