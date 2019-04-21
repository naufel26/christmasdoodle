//
//  ViewController.swift
//  EmojiKeyboard
//
//  Created by Tanvir Hasan Piash on 11/8/16.
//  Copyright © 2016 creativeitem. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "background") // change the background image here if needed
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var infoButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "infoButtonIcon"), for: .normal) // change the info button image here if needed
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleInfoButton), for: .touchUpInside)
        return button
    }()
    
    lazy var appButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "appButtonIcon"), for: .normal) // change the app redirect button image here if needed
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleAppButton), for: .touchUpInside)
        return button
    }()
    
    lazy var infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "info") // change the info image here if needed
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleInfoImageTap(_:))))
        return imageView
    }()
    
    // change the app url or pro app url here
    let appUrl = URL(string: "https://itunes.apple.com/us/app/thanks-emoji-pro/id1177390787")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        
        setupInfoButton()
        
        setupAppButton()
    }
    
    // adds the background image
    func setupBackground() {
        view.addSubview(backgroundImageView)
        // contraints
        backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    // adds info button
    func setupInfoButton() {
        view.addSubview(infoButton)
        // contraints
        infoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -60).isActive = true
        infoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        infoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
        infoButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    func handleInfoButton() {
        view.addSubview(infoImageView)
        Animations.animateIn(view: infoImageView, duration: 0.3, delay: 0, scaleX: 0.3, scaleY: 0.3)
        // constraints
        infoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        infoImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        infoImageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    // adds the app button
    func setupAppButton() {
        view.addSubview(appButton)
        // contraints
        appButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 60).isActive = true
        appButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        appButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
        appButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    func handleAppButton() {
        guard let url = appUrl else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }
    
    func handleInfoImageTap(_ sender: UITapGestureRecognizer) {
        Animations.animateOut(view: infoImageView, duration: 0.3, delay: 0, scaleX: 0.3, scaleY: 0.3, removeFromSuperview: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }


}

