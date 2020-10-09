//
//  ProductDetailsView.swift
//  SquirrelStorage
//
//  Created by Rodrigo Matos Aguiar on 17/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class ProductDetailView: UIView {
    
    weak var delegate: ProductDetailViewDelegate?
    
    // MARK: Views
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .background
        return imageView
    }()
    
    let detailCard: UIView = {
        let detailCard = UIView()
        detailCard.backgroundColor = .background
        detailCard.layer.cornerRadius = 32
        detailCard.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return detailCard
    }()
    
    let quantityBar: UIView = {
        let quantityBar = UIView()
        quantityBar.backgroundColor = .purpleSS
        return quantityBar
    }()
    
    let cardTitle: UILabel = {
        let cardTitle = UILabel()
        cardTitle.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        cardTitle.textColor = .largeTitle
        return cardTitle
    }()
    
    let cardCategory: UILabel = {
        let cardCategory = UILabel()
        cardCategory.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        cardCategory.textColor = .smallText
        return cardCategory
    }()
    
    let starButton: UIButton = {
        let starButton = UIButton(type: .custom)
        let scaleConfig = UIImage.SymbolConfiguration(scale: .large)
        starButton.setImage(UIImage(systemName: "star", withConfiguration: scaleConfig), for: .normal)
        starButton.setImage(UIImage(systemName: "star.fill", withConfiguration: scaleConfig), for: .selected)
        starButton.tintColor = .yellowSS
        starButton.addTarget(self, action: #selector(starButtonPressed), for: .touchUpInside)
        return starButton
    }()
    
    let salePrice: UILabel = {
        let salePrice = UILabel()
        salePrice.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        salePrice.textAlignment = .center
        salePrice.textColor = .darkPurpleSS
        return salePrice
    }()
    
    let costPrice: UILabel = {
        let costPrice = UILabel()
        costPrice.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        costPrice.textAlignment = .center
        costPrice.textColor = .largeTitle
        return costPrice
    }()
    
    let salePriceIndicator: UILabel = {
        let salePriceIndicator = UILabel()
        salePriceIndicator.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        salePriceIndicator.textColor = .smallText
        salePriceIndicator.text = "Venda"
        return salePriceIndicator
    }()
    
    let costPriceIndicator: UILabel = {
        let costPriceIndicator = UILabel()
        costPriceIndicator.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        costPriceIndicator.textColor = .smallText
        costPriceIndicator.text = "Custo"
        return costPriceIndicator
    }()
    
    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        descriptionLabel.textColor = .largeTitle
        descriptionLabel.text = "Descrição"
        return descriptionLabel
    }()
    
    let descriptionTextView: UITextView = {
        let descriptionTextView = UITextView()
        descriptionTextView.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        descriptionTextView.textColor = .smallText
        descriptionTextView.backgroundColor = .background
        descriptionTextView.textContainerInset = UIEdgeInsets.zero
        descriptionTextView.textContainer.lineFragmentPadding = 0
        descriptionTextView.isEditable = false
        return descriptionTextView
    }()
    
    let quantityImageView: UIImageView = {
        let image = UIImage(named: "QuantityIcon")
        let quantityImageView = UIImageView(image: image)
        return quantityImageView
    }()
    
    let currentQuantity: UILabel = {
        let currentQuantity = UILabel()
        currentQuantity.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        currentQuantity.textColor = .background
        return currentQuantity
    }()
    
    let increaseQuantityButton: UIButton = {
        let increaseQuantityButton = UIButton()
        let font = UIFont.boldSystemFont(ofSize: 20)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.purpleSS
        ]
        let title = NSAttributedString(string: "+", attributes: attributes)
        increaseQuantityButton.setAttributedTitle(title, for: .normal)
        increaseQuantityButton.backgroundColor = .background
        increaseQuantityButton.layer.cornerRadius = 4
        increaseQuantityButton.addTarget(self, action: #selector(increaseQuantityButtonPressed), for: .touchUpInside)
        increaseQuantityButton.addTarget(self, action: #selector(quantityButtonDown(sender:)), for: .touchDown)
        return increaseQuantityButton
    }()
    
    let decreaseQuantityButton: UIButton = {
        let decreaseQuantityButton = UIButton()
        let font = UIFont.boldSystemFont(ofSize: 20)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.purpleSS
        ]
        let title = NSAttributedString(string: "-", attributes: attributes)
        decreaseQuantityButton.setAttributedTitle(title, for: .normal)
        decreaseQuantityButton.backgroundColor = .background
        decreaseQuantityButton.layer.cornerRadius = 4
        decreaseQuantityButton.addTarget(self, action: #selector(decreaseQuantityButtonPressed), for: .touchUpInside)
        decreaseQuantityButton.addTarget(self, action: #selector(quantityButtonDown(sender:)), for: .touchDown)
        return decreaseQuantityButton
    }()
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        setupImageView()
        setupQuantityBar()
        setupDetailCard()
        setupCardTitle()
        setupCardCategory()
        setupStarButton()
        setupSalePrice()
        setupCostPrice()
        setupSalePriceIndicator()
        setupCostPriceIndicator()
        setupDescriptionLabel()
        setupDescriptionTextView()
        setupQuantityImageView()
        setupIncreaseQuantityButton()
        setupDecreaseQuantityButton()
        setupCurrentQuantity()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        detailCard.layer.shadowPath = UIBezierPath(
            roundedRect: CGRect(x: 0, y: 0, width: detailCard.bounds.width, height: detailCard.layer.cornerRadius),
            cornerRadius: detailCard.layer.cornerRadius).cgPath
        detailCard.layer.shadowRadius = 15
        detailCard.layer.shadowOffset = .zero
        detailCard.layer.shadowOpacity = 0.2
    }
    
    // MARK: Actions
    
    @objc func starButtonPressed() {
        starButton.isSelected.toggle()
        delegate?.favorite(starButton.isSelected)
    }
    
    @objc func increaseQuantityButtonPressed() {
        increaseQuantityButton.backgroundColor = .background
        delegate?.increaseQuantity()
    }
    
    @objc func decreaseQuantityButtonPressed() {
        decreaseQuantityButton.backgroundColor = .background
        delegate?.decreaseQuantity()
    }
    
    @objc func quantityButtonDown(sender: UIButton) {
        sender.backgroundColor = .lightGray
    }
    
    // MARK: Setup
    
    func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.47)
        ])
    }
    
    func setupDetailCard() {
        addSubview(detailCard)
        detailCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailCard.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -detailCard.layer.cornerRadius),
            detailCard.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            detailCard.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            detailCard.bottomAnchor.constraint(equalTo: quantityBar.topAnchor)
        ])
    }
    
    func setupQuantityBar() {
        addSubview(quantityBar)
        quantityBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quantityBar.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.08),
            quantityBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            quantityBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            quantityBar.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupCardTitle() {
        addSubview(cardTitle)
        cardTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardTitle.leadingAnchor.constraint(equalTo: detailCard.leadingAnchor, constant: 16),
            cardTitle.topAnchor.constraint(equalTo: detailCard.topAnchor, constant: 28)
        ])
    }
    
    func setupCardCategory() {
        addSubview(cardCategory)
        cardCategory.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardCategory.leadingAnchor.constraint(equalTo: cardTitle.leadingAnchor),
            cardCategory.topAnchor.constraint(equalTo: cardTitle.bottomAnchor, constant: 4)
        ])
    }
    
    func setupStarButton() {
        addSubview(starButton)
        starButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starButton.trailingAnchor.constraint(equalTo: detailCard.trailingAnchor, constant: -31),
            starButton.topAnchor.constraint(equalTo: detailCard.topAnchor, constant: 32)
        ])
    }
    
    func setupSalePrice() {
        addSubview(salePrice)
        salePrice.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            salePrice.leadingAnchor.constraint(equalTo: detailCard.leadingAnchor, constant: 20),
            salePrice.topAnchor.constraint(equalTo: cardCategory.bottomAnchor, constant: 32)
        ])
    }
    
    func setupCostPrice() {
        addSubview(costPrice)
        costPrice.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            costPrice.trailingAnchor.constraint(equalTo: detailCard.trailingAnchor, constant: -20),
            costPrice.leadingAnchor.constraint(equalTo: salePrice.trailingAnchor, constant: 20),
            costPrice.widthAnchor.constraint(equalTo: salePrice.widthAnchor),
            costPrice.topAnchor.constraint(equalTo: cardCategory.bottomAnchor, constant: 32)
        ])
    }
    
    func setupSalePriceIndicator() {
        addSubview(salePriceIndicator)
        salePriceIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            salePriceIndicator.centerXAnchor.constraint(equalTo: salePrice.centerXAnchor),
            salePriceIndicator.topAnchor.constraint(equalTo: salePrice.bottomAnchor, constant: 5)
        ])
    }
    
    func setupCostPriceIndicator() {
        addSubview(costPriceIndicator)
        costPriceIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            costPriceIndicator.centerXAnchor.constraint(equalTo: costPrice.centerXAnchor),
            costPriceIndicator.topAnchor.constraint(equalTo: costPrice.bottomAnchor, constant: 5)
        ])
    }
    
    func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: cardTitle.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: salePriceIndicator.bottomAnchor, constant: 32)
        ])
    }
    
    func setupDescriptionTextView() {
        addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionTextView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            descriptionTextView.trailingAnchor.constraint(equalTo: detailCard.trailingAnchor, constant: -16),
            descriptionTextView.bottomAnchor.constraint(equalTo: detailCard.bottomAnchor, constant: -35)
        ])
    }
    
    func setupQuantityImageView() {
        addSubview(quantityImageView)
        quantityImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quantityImageView.leadingAnchor.constraint(equalTo: quantityBar.leadingAnchor, constant: 16),
            quantityImageView.centerYAnchor.constraint(equalTo: quantityBar.centerYAnchor),
            quantityImageView.widthAnchor.constraint(equalTo: quantityBar.heightAnchor, multiplier: 0.4),
            quantityImageView.heightAnchor.constraint(equalTo: quantityBar.heightAnchor, multiplier: 0.4)
        ])
    }
    
    func setupCurrentQuantity() {
        addSubview(currentQuantity)
        currentQuantity.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentQuantity.leadingAnchor.constraint(equalTo: quantityImageView.trailingAnchor, constant: 16),
            currentQuantity.trailingAnchor.constraint(equalTo: decreaseQuantityButton.leadingAnchor, constant: -16),
            currentQuantity.centerYAnchor.constraint(equalTo: quantityBar.centerYAnchor)
        ])
    }
    
    func setupIncreaseQuantityButton() {
        addSubview(increaseQuantityButton)
        increaseQuantityButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            increaseQuantityButton.centerYAnchor.constraint(equalTo: quantityBar.centerYAnchor),
            increaseQuantityButton.trailingAnchor.constraint(equalTo: quantityBar.trailingAnchor, constant: -24),
            increaseQuantityButton.widthAnchor.constraint(equalTo: quantityBar.heightAnchor, multiplier: 0.5),
            increaseQuantityButton.heightAnchor.constraint(equalTo: quantityBar.heightAnchor, multiplier: 0.5)
        ])
    }
    
    func setupDecreaseQuantityButton() {
        addSubview(decreaseQuantityButton)
        decreaseQuantityButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            decreaseQuantityButton.centerYAnchor.constraint(equalTo: quantityBar.centerYAnchor),
            decreaseQuantityButton.trailingAnchor.constraint(equalTo: increaseQuantityButton.leadingAnchor, constant: -24),
            decreaseQuantityButton.widthAnchor.constraint(equalTo: increaseQuantityButton.widthAnchor),
            decreaseQuantityButton.heightAnchor.constraint(equalTo: increaseQuantityButton.heightAnchor)
        ])
    }
}
