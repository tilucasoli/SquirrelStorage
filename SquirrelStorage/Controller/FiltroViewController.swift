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
        //view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowRadius = 10
        view.layer.shadowColor = UIColor.purpleSS.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    // to store backing (snapshot) image
    var backingImage: UIImage?
    
    var topConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageSnapshot.image = backingImage
        setupImageSnapshot()
        setupDarkView()
        setupCardView()
        
        // hide the card view at the bottom when the View first load
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        let bottomPadding = view.safeAreaInsets.bottom
        topConstraint.constant = (safeAreaHeight + bottomPadding)
        
        // set dimmerview to transparent
        darkView.alpha = 0.0
        
        // dimmerViewTapped() will be called when user tap on the dimmer view
        let darkTap = UITapGestureRecognizer(target: self, action: #selector(darkViewTapped(_:)))
        darkView.addGestureRecognizer(darkTap)
        darkView.isUserInteractionEnabled = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showCard()
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
        topConstraint = cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        topConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate([
            topConstraint,
            cardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cardView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            cardView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        
    }
    
    // MARK: Animations
    private func showCard() {
        // ensure there's no pending layout changes before animation runs
        self.view.layoutIfNeeded()
        
        // set the new top constraint value for card view
        // card view won't move up just yet, we need to call layoutIfNeeded()
        // to tell the app to refresh the frame/position of card view
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        let bottomPadding = view.safeAreaInsets.bottom
        
          // when card state is normal, its top distance to safe area is
          // (safe area height + bottom inset) / 2.0
        topConstraint.constant = (safeAreaHeight + bottomPadding) / 2
        
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
            topConstraint.constant = safeAreaHeight + bottomPadding
          
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
          
          // run the animation
          hideCard.startAnimation()
        
    }
    
}
