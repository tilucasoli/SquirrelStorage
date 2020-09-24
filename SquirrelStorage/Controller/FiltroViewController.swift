//
//  FiltroViewController.swift
//  SquirrelStorage
//
//  Created by Lucas Oliveira on 21/09/20.
//  Copyright © 2020 Lucas Oliveira. All rights reserved.
//

import UIKit

class FiltroViewController: UIViewController {
    
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
    
    // to store backing (snapshot) image
    var backingImage: UIImage?
    
    var cardViewTopConstraint: NSLayoutConstraint!
    
    enum CardViewState {
        case expanded
        case normal
    }
    
    // default card view state is normal
    var cardViewState: CardViewState = .normal
    
    // to store the card view top constraint value before the dragging start
    // default is 30 pt from safe area top
    var cardPanStartingTopConstant: CGFloat = 30.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageSnapshot.image = backingImage
        setupImageSnapshot()
        setupDarkView()
        setupCardView()
        
        // hide the card view at the bottom when the View first load
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        let bottomPadding = view.safeAreaInsets.bottom
        cardViewTopConstraint.constant = (safeAreaHeight + bottomPadding)
        
        // set dimmerview to transparent
        darkView.alpha = 0.0
        
        // dimmerViewTapped() will be called when user tap on the dimmer view
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
    
    // this function will be called when user pan/drag the view
    @objc func viewPanned(_ panRecognizer: UIPanGestureRecognizer) {
        // how much has user dragged
        let translation = panRecognizer.translation(in: self.view)
        
        switch panRecognizer.state {
        case .began:
            cardPanStartingTopConstant = cardViewTopConstraint.constant
        case .changed :
            if self.cardPanStartingTopConstant + translation.y > 30.0 {
                self.cardViewTopConstraint.constant = self.cardPanStartingTopConstant + translation.y
            }
        case .ended :
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
    
    @objc func darkViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideCardAndGoBack()
    }
    
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
    
    // MARK: Animations
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
            cardViewTopConstraint.constant = (safeAreaHeight + bottomPadding) / 2.0
        }
        // when card state is normal, its top distance to safe area is
        // (safe area height + bottom inset) / 2.0
        cardPanStartingTopConstant = cardViewTopConstraint.constant
        
        // move card up from bottom by telling the app to refresh the frame/position of view
        // create a new property animator
        let showCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn, animations: {
            self.view.layoutIfNeeded()
        })
        
        // show dimmer view
        // this will animate the dimmerView alpha together with the card move up animation
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
        
        // hide dimmer view
        // this will animate the dimmerView alpha together with the card move down animation
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
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .soft)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        // run the animation
        hideCard.startAnimation()
        
    }
    
}
