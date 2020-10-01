//
//  FiltroViewController.swift
//  SquirrelStorage
//
//  Created by Lucas Oliveira on 21/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class FiltroViewController: UIViewController {
    
    var filtroList = [(title: "Menor Preço", icon: "Dolar"), (title: "Maior Preço", icon: "Dolar"), (title: "Quantidade", icon: "Dolar")]
    
    var categoriasList = Array(Set(EstoqueViewController.productList.map({$0.category}))).filter({$0 != " "})
    
//    var productList = []
    
    var ultimoFiltro: AgruparFiltroCollectionViewCell?
    
    enum CardViewState {
        case expanded
        case normal
    }
    
    // to store backing (snapshot) image
    var backingImage: UIImage?
    
    // top constraint cardView
    var cardViewTopConstraint: NSLayoutConstraint!
    
    // default card view state is normal
    var cardViewState: CardViewState = .normal
    
    // to store the card view top constraint value before the dragging start
    // default is 30 pt from safe area top
    var cardPanStartingTopConstant: CGFloat = 30.0
    
    let imageSnapshot: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    let darkView: UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.backgroundColor = UIColor.purpleSS.withAlphaComponent(0.7)
        return view
    }()
    
    let cardView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        return view
    }()
    
    let handleView: UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 3.0
        view.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        return view
    }()
    
    let navView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Filtros"
        label.textColor = .largeTitle
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        button.setTitle("Limpar", for: .normal)
        button.setTitleColor(.purpleSS, for: .normal)
        button.tintColor = UIColor.purpleSS
        button.addTarget(self, action: #selector(clearFilter), for: .touchUpInside)
        return button
    }()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        button.setTitle("Fechar", for: .normal)
        button.setTitleColor(.purpleSS, for: .normal)
        button.tintColor = UIColor.purpleSS
        button.addTarget(self, action: #selector(closeFilter), for: .touchUpInside)
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let screenSize = UIScreen.main.bounds.width
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: 152, height: 36)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4

        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.register(AgruparFiltroCollectionViewCell.self, forCellWithReuseIdentifier: "AgruparFiltro")
        collectionView.register(HeaderFilterCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        
        return collectionView
    }()
    
    let viewButton: UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        return view
    }()
    
    let filterButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        button.setTitle("Filtrar", for: .normal)
        button.setTitleColor(.background, for: .normal)
        button.backgroundColor = .purpleSS
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageSnapshot()
        setupDarkView()
        setupCardView()
        setupHandleView()
        setupNavView()
        setupTitleLabel()
        setupCloseButton()
        setupClearButton()
        setupviewButtom()
        setupCollectionView()
        setupFilterButton()

        // saving back image from Estoque
        imageSnapshot.image = backingImage
        
        // hide the card view at the bottom when the View first load
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        let bottomPadding = view.safeAreaInsets.bottom
        cardViewTopConstraint.constant = (safeAreaHeight + bottomPadding)
        
        // set darkview to transparent
        darkView.alpha = 0.0
        
        // darkViewTapped() will be called when user tap on the dark view
        let darkTap = UITapGestureRecognizer(target: self, action: #selector(darkViewTapped(_:)))
        darkView.addGestureRecognizer(darkTap)
        darkView.isUserInteractionEnabled = true
        
        // add pan gesture recognizer to the view controller's view (the whole screen)
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        // by default iOS will delay the touch before recording the drag/pan information
        // we want the drag gesture to be recorded down immediately, hence setting no delay
        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false
        self.view.addGestureRecognizer(viewPan)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showCard()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.layoutIfNeeded()
    }
    
    // this function will be called when user tap on the dark view
    @objc func darkViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideCardAndGoBack()
    }
    
    // this function will be called when user pan/drag the view
    @objc func viewPanned(_ panRecognizer: UIPanGestureRecognizer) {
        
        // how much has user dragged
        let translation = panRecognizer.translation(in: self.view)
        
        // how fast the user drag
        let velocity = panRecognizer.velocity(in: self.view)
        
        switch panRecognizer.state {
        case .began:
            
            cardPanStartingTopConstant = cardViewTopConstraint.constant
            
        case .changed :
            
            if self.cardPanStartingTopConstant + translation.y > 30.0 {
                self.cardViewTopConstraint.constant = self.cardPanStartingTopConstant + translation.y
            }
            
            // change the dark view alpha based on how much user has dragged
            darkView.alpha = darkAlphaWithCardTopConstraint(value: self.cardViewTopConstraint.constant)
            
        case .ended :
            
            // if user drag down with a very fast speed (ie. swipe)
            if velocity.y > 1500.0 {
                // hide the card and dismiss current view controller
                hideCardAndGoBack()
                return
            }
            
            let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
            let bottomPadding = view.safeAreaInsets.bottom
            
            if self.cardViewTopConstraint.constant < (safeAreaHeight + bottomPadding) * 0.25 {
                // show the card at expanded state
                showCard(atState: .expanded)
            } else if self.cardViewTopConstraint.constant < (safeAreaHeight) - 70 {
                // show the card at normal state
                showCard(atState: .normal)
            } else {
                // hide the card and dismiss current view controller
                hideCardAndGoBack()
            }
            
        default:
            break
        }
    }
    
    // this function returns the opacity value of the darkView
    private func darkAlphaWithCardTopConstraint(value: CGFloat) -> CGFloat {
        let fullDimAlpha: CGFloat = 0.7
        
        // ensure safe area height and safe area bottom padding is not nil
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        let bottomPadding = view.safeAreaInsets.bottom
        
        // when card view top constraint value is equal to this,
        // the dark view alpha is dimmest (0.7)
        let fullDimPosition = (safeAreaHeight + bottomPadding) / 2.0
        
        // when card view top constraint value is equal to this,
        // the dark view alpha is lightest (0.0)
        let noDimPosition = safeAreaHeight + bottomPadding
        
        // if card view top constraint is lesser than fullDimPosition
        // it is dimmest
        if value < fullDimPosition {
            return fullDimAlpha
        }
        
        // if card view top constraint is more than noDimPosition
        // it is dimmest
        if value > noDimPosition {
            return 0.0
        }
        
        // else return an alpha value in between 0.0 and 0.7 based on the top constraint value
        return fullDimAlpha * 1 - ((value - fullDimPosition) / fullDimPosition)
    }
    
    @objc func clearFilter() {
        let itens = collectionView.visibleCells as! [AgruparFiltroCollectionViewCell]
        for item in itens {
            item.active = false
        }
    }
    
    @objc func closeFilter() {
        hideCardAndGoBack()
    }
    
    @objc func filterAction() {
        if ultimoFiltro?.titleLabel.text == "Menor Preço" {
            let list = EstoqueViewController.productList.sorted(by: {$0.costPrice < $1.costPrice})
            EstoqueViewController.showedProductList = list
        }
        
        else if ultimoFiltro?.titleLabel.text == "Maior Preço" {
            let list = EstoqueViewController.productList.sorted(by: {$0.costPrice > $1.costPrice})
            EstoqueViewController.showedProductList = list
        }
        
        else if ultimoFiltro?.titleLabel.text == "Quantidade" {
            let list = EstoqueViewController.productList.sorted(by: {$0.quantity > $1.quantity})
            EstoqueViewController.showedProductList = list
        }
        hideCardAndGoBack()
    }
    
    // MARK: Setups
    func setupImageSnapshot() {
        view.addSubview(imageSnapshot)
        imageSnapshot.translatesAutoresizingMaskIntoConstraints = false
        imageSnapshot.accessibilityIdentifier = "image Snapshot"
        NSLayoutConstraint.activate([
            imageSnapshot.topAnchor.constraint(equalTo: view.topAnchor),
            imageSnapshot.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageSnapshot.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageSnapshot.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func setupDarkView() {
        view.addSubview(darkView)
        darkView.translatesAutoresizingMaskIntoConstraints = false
        darkView.accessibilityIdentifier = "dark View"
        NSLayoutConstraint.activate([
            darkView.topAnchor.constraint(equalTo: view.topAnchor),
            darkView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            darkView.leftAnchor.constraint(equalTo: view.leftAnchor),
            darkView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func setupCardView() {
        view.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.accessibilityIdentifier = "Card View"
        cardViewTopConstraint = cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        cardViewTopConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate([
            cardViewTopConstraint,
            cardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cardView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            cardView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
    }
    
    func setupHandleView() {
        view.addSubview(handleView)
        handleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            handleView.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: -10),
            handleView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            handleView.heightAnchor.constraint(equalToConstant: 5),
            handleView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupNavView() {
        view.addSubview(navView)
        navView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            navView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            navView.heightAnchor.constraint(equalToConstant: 35),
            navView.widthAnchor.constraint(equalTo: cardView.widthAnchor)
        ])
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: navView.topAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: navView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: navView.centerYAnchor)
        ])
    }
    
    func setupClearButton() {
        view.addSubview(clearButton)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: navView.topAnchor, constant: 8),
            clearButton.rightAnchor.constraint(equalTo: navView.rightAnchor, constant: -20),
            clearButton.centerYAnchor.constraint(equalTo: navView.centerYAnchor)
        ])
    }
    
    func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: navView.topAnchor, constant: 8),
            closeButton.leftAnchor.constraint(equalTo: navView.leftAnchor, constant: 20),
            closeButton.centerYAnchor.constraint(equalTo: navView.centerYAnchor)
        ])
        
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: navView.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: cardView.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: cardView.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: viewButton.topAnchor)
        ])
    }
    
    func setupviewButtom() {
        view.addSubview(viewButton)
        viewButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            viewButton.leftAnchor.constraint(equalTo: cardView.leftAnchor),
            viewButton.heightAnchor.constraint(equalToConstant: 85),
            viewButton.rightAnchor.constraint(equalTo: cardView.rightAnchor)
        ])
    }
    
    func setupFilterButton() {
        view.addSubview(filterButton)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: viewButton.topAnchor, constant: 16),
            filterButton.centerXAnchor.constraint(equalTo: viewButton.centerXAnchor),
            filterButton.bottomAnchor.constraint(equalTo: viewButton.bottomAnchor, constant: -20),
            filterButton.leftAnchor.constraint(equalTo: viewButton.leftAnchor, constant: 16),
            filterButton.rightAnchor.constraint(equalTo: viewButton.rightAnchor, constant: -16)
        ])
    }
    
    // MARK: Animations
    
    // this function shows the cardView according to the state
    private func showCard(atState: CardViewState = .normal) {
        // ensure there's no pending layout changes before animation runs
        self.view.layoutIfNeeded()
        
        // set the new top constraint value for card view
        // card view won't move up just yet, we need to call layoutIfNeeded()
        // to tell the app to refresh the frame/position of card view
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        let bottomPadding = view.safeAreaInsets.bottom
        
        if atState == .expanded {
            // if state is expanded, top constraint is 30pt away from safe area top
            cardViewTopConstraint.constant = 30.0
        } else {
            cardViewTopConstraint.constant = (safeAreaHeight + bottomPadding) / 2.7
        }
        
        // when card state is normal, its top distance to safe area is
        // (safe area height + bottom inset) / 2.0
        cardPanStartingTopConstant = cardViewTopConstraint.constant
        
        // move card up from bottom by telling the app to refresh the frame/position of view
        // create a new property animator
        let showCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn, animations: {
            self.view.layoutIfNeeded()
        })
        
        // show dark view
        // this will animate the darkView alpha together with the card move up animation
        showCard.addAnimations({
            self.darkView.alpha = 0.7
        })
        
        // run the animation
        showCard.startAnimation()
    }
    
    private func hideCardAndGoBack() {
        
        // ensure there's no pending layout changes before animation runs
        self.view.layoutIfNeeded()
        
        // set the new top constraint value for card view
        // card view won't move down just yet, we need to call layoutIfNeeded()
        // to tell the app to refresh the frame/position of card view
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        let bottomPadding = view.safeAreaInsets.bottom
        
        // move the card view to bottom of screen
        cardViewTopConstraint.constant = safeAreaHeight + bottomPadding
        
        // move card down to bottom
        // create a new property animator
        let hideCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn, animations: {
            self.view.layoutIfNeeded()
        })
        
        // hide dark view
        // this will animate the darkView alpha together with the card move down animation
        hideCard.addAnimations {
            self.darkView.alpha = 0.0
        }
        
        // when the animation completes, (position == .end means the animation has ended)
        // dismiss this view controller (if there is a presenting view controller)
        hideCard.addCompletion({ position in
            if position == .end {
                if self.presentingViewController != nil {
                    self.dismiss(animated: false, completion: nil)
                }
            }
        })
        
        // run the animation
        hideCard.startAnimation()
        
        // add an impact feedback
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .soft)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        
    }
}

// MARK: Collection View
extension FiltroViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? filtroList.count : categoriasList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                         withReuseIdentifier: "headerView", for: indexPath) as! HeaderFilterCollectionReusableView
        
        if indexPath.section == 0 {
            headerView.titleLabel.text = "Agrupar por"
        }
        if indexPath.section == 1 {
            headerView.titleLabel.text = "Categorias"
        }
        return headerView
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgruparFiltro", for: indexPath) as! AgruparFiltroCollectionViewCell
        if indexPath.section == 0 {
            cell.configureCell(title: filtroList[indexPath.row].title, icon: filtroList[indexPath.row].icon)
            
        } else {
            cell.configureCell(title: categoriasList[indexPath.row], icon: nil)
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! AgruparFiltroCollectionViewCell
        
        if indexPath.section == 0 {
            if !cell.active {
                if let filtro = ultimoFiltro {
                    filtro.active = false
                }
                ultimoFiltro = cell
                cell.active.toggle()
            }
        } else {
            cell.active.toggle()
        }
        
    }

}
