//
//  Animations.swift
//  PhotoFrame
//
//  Created by Tanvir Hasan Piash on 11/10/16.
//  Copyright © 2016 creativeitem. All rights reserved.
//

import UIKit

class Animations {
    
    class func animateIn(view: UIView, duration: TimeInterval, delay: TimeInterval, scaleX: CGFloat, scaleY:CGFloat) {
        view.transform = CGAffineTransform.init(scaleX: scaleX, y: scaleY)
        view.alpha = 0
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
            view.transform = CGAffineTransform.identity
            view.alpha = 1
        }, completion: nil)
    }
    
    class func animateOut(view: UIView, duration: TimeInterval, delay: TimeInterval, scaleX: CGFloat, scaleY:CGFloat, removeFromSuperview: Bool) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
            view.transform = CGAffineTransform.init(scaleX: scaleX, y: scaleY)
            view.alpha = 0
        }, completion: { (completed) in
            removeFromSuperview ? view.removeFromSuperview() : print("not allowed to remove from superview")
        })
    }
}
