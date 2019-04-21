//
//  KeyboardViewController.swift
//  emojiKey
//
//  Created by Tanvir Hasan Piash on 11/8/16.
//  Copyright © 2016 creativeitem. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.register(UINib(nibName: "EmojiCell", bundle: nil), forCellWithReuseIdentifier: "EmojiCell")
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nextKeyboardButton: UIButton = {
        let button = UIButton()
        button.setTitle("🌐", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleNextKeyboardButton(_:)), for: .touchUpInside)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var backspaceButton: UIButton = {
        let button = UIButton()
        button.setTitle("✕", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleBackspace(_:)), for: .touchUpInside)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var defaultKeyboardView: UIView!
    
    let topLayoutView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let clipboardInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "copied to clipboard"
        label.textAlignment = .center
        label.alpha = 0
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var capsOn: Bool = false
    
    var emojis = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        if isOpenAccessGranted() {
            initiateTopLayout()
            initiateEmojiKeyboard()
        } else {
            initiateDefaultKeyboard()
        }
        
        initiateEmojis()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    
    // Configure the emoji name array here
    func initiateEmojis() {
        emojis.removeAll()
        
        for i in 1...100 {
            emojis.append("em\(i).png")
        }
    }
    
    func initiateTopLayout() {
        view.addSubview(topLayoutView)
        // constraints
        topLayoutView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topLayoutView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topLayoutView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topLayoutView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
        
        initiateClipboardInfoLabel()
        
        initiateNextKeyboardButton()
        
        initiateBackspaceButton()
    }
    
    func initiateClipboardInfoLabel() {
        topLayoutView.addSubview(clipboardInfoLabel)
        // constraints
        clipboardInfoLabel.centerXAnchor.constraint(equalTo: topLayoutView.centerXAnchor).isActive = true
        clipboardInfoLabel.centerYAnchor.constraint(equalTo: topLayoutView.centerYAnchor).isActive = true
        clipboardInfoLabel.heightAnchor.constraint(equalTo: topLayoutView.heightAnchor).isActive = true
        clipboardInfoLabel.widthAnchor.constraint(equalTo: topLayoutView.widthAnchor, multiplier: 0.6).isActive = true
    }
    
    func initiateNextKeyboardButton() {
        topLayoutView.addSubview(nextKeyboardButton)
        // constraints
        nextKeyboardButton.rightAnchor.constraint(equalTo: clipboardInfoLabel.leftAnchor, constant: 4).isActive = true
        nextKeyboardButton.leftAnchor.constraint(equalTo: topLayoutView.leftAnchor).isActive = true
        nextKeyboardButton.heightAnchor.constraint(equalTo: topLayoutView.heightAnchor).isActive = true
    }
    
    func initiateBackspaceButton() {
        topLayoutView.addSubview(backspaceButton)
        // constraints
        backspaceButton.leftAnchor.constraint(equalTo: clipboardInfoLabel.rightAnchor, constant: 4).isActive = true
        backspaceButton.rightAnchor.constraint(equalTo: topLayoutView.rightAnchor).isActive = true
        backspaceButton.heightAnchor.constraint(equalTo: topLayoutView.heightAnchor).isActive = true
    }
    
    func handleBackspace(_ sender: UIButton) {
        self.textDocumentProxy.deleteBackward()
    }
    
    func handleNextKeyboardButton(_ sender: UIButton) {
        advanceToNextInputMode()
    }
    
    func initiateEmojiKeyboard() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        // constraints
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 2).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.80).isActive = true
    }
    
    func copyEmojiToClipboard(index: Int) {
        let imageToCopy = UIImage(named: "em\(index).png")!
        UIPasteboard.general.image = imageToCopy
        toggleClipboardInfoLabel()
    }
    
    func toggleClipboardInfoLabel() {
        UIView.animate(withDuration: 0.33, animations: {
            self.clipboardInfoLabel.alpha = 1.0
        }, completion: { (success) in
            UIView.animate(withDuration: 0.33, delay: 1, animations: {
                self.clipboardInfoLabel.alpha = 0
            })
        })
    }
    
    // initiate the default keyboard
    func initiateDefaultKeyboard() {
        let nib = UINib(nibName: "DefaultKeyboard", bundle: nil)
        defaultKeyboardView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.addSubview(defaultKeyboardView)
        defaultKeyboardView.clipsToBounds = true
        defaultKeyboardView.translatesAutoresizingMaskIntoConstraints = false
        // constraints
        defaultKeyboardView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        defaultKeyboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        defaultKeyboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        defaultKeyboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // change keyboard
    @IBAction func nextInputMethod(_ sender: UIButton) {
        advanceToNextInputMode()
    }
    
    // add letter
    @IBAction func addLetter(_ sender:UIButton) {
        self.textDocumentProxy.insertText((sender.titleLabel?.text)!)
    }
    
    // add space
    @IBAction func addSpace(_ sender:UIButton) {
        self.textDocumentProxy.insertText(" ")
    }
    
    // delete
    @IBAction func deleteLetter(_ sender:UIButton) {
        self.textDocumentProxy.deleteBackward()
    }
    
    // toggle caps
    @IBAction func toggleCaps(_ sender:UIButton) {
        capsOn = !capsOn
        for v:UIView in self.view.subviews {
            for v2:UIView in v.subviews {
                for v3:UIView in v2.subviews {
                    for v4:UIView in v3.subviews {
                        if v4 is UIButton && v4.tag < 10 {
                            let word = ((capsOn) ? (v4 as! UIButton).currentTitle?.uppercased() : (v4 as! UIButton).currentTitle?.lowercased())
                            (v4 as! UIButton).setTitle(word, for: UIControlState())
                            (v4 as! UIButton).setTitle(word, for: .highlighted)
                            (v4 as! UIButton).setTitle(word, for: .selected)
                        }
                    }
                }
            }
        }
    }
    
    // return action
    @IBAction func returnAction(_ sender:UIButton) {
        dismissKeyboard()
    }
    
    // check for full access
    func isOpenAccessGranted() -> Bool {
        let originalString = UIPasteboard.general.string
        UIPasteboard.general.string = "TEST"
        if #available(iOSApplicationExtension 10.0, *) {
            if UIPasteboard.general.hasStrings
            {
                UIPasteboard.general.string = originalString
                return true
            }
            else
            {
                return false
            }
        } else {
            // Fallback on earlier versions
            return UIPasteboard.general.isKind(of: UIPasteboard.self)
        }
    }

}

// COLLECTION VIEW DELEGATE METHODS
extension KeyboardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if emojis.count > 0 {
            return emojis.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath) as? EmojiCell {
            let image = UIImage(named: "\(emojis[indexPath.item])")!
            let scaledImage = image.scaleImageToSize(newSize: CGSize(width: 80, height: 80))
            cell.image = scaledImage
            return cell
        } else {
            return EmojiCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item + 1
        copyEmojiToClipboard(index: index)
    }
}

// COLLECTION VIEW DELEGATE FLOW LAYOUT METHODS
extension KeyboardViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 5, 10, 0)
    }
}






















