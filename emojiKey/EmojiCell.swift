//
//  EmojiCell.swift
//  EmojiKeyboard
//
//  Created by Tanvir Hasan Piash on 11/9/16.
//  Copyright © 2016 creativeitem. All rights reserved.
//

import UIKit

class EmojiCell: UICollectionViewCell {
    
    @IBOutlet weak var emojiImage: UIImageView!
    
    var image: UIImage! {
        didSet {
            emojiImage.image = image
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        emojiImage.image = nil
    }

}
