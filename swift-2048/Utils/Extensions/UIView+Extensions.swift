//
//  UIView+Extensions.swift
//  swift-2048
//
//  Created by joe on 08/03/23.
//

import UIKit

extension UIView {
    /**
     Returns a spacer with provided size
     - parameter size: size of the spacer to be created
     */
     static func spacer(size: CGFloat = 10, for layout: NSLayoutConstraint.Axis = .vertical) -> UIView {
        let spacer = UIView()
        if layout == .horizontal {
            spacer.widthAnchor.constraint(equalToConstant: size).isActive = true
        } else {
            spacer.heightAnchor.constraint(equalToConstant: size).isActive = true
        }
        
        return spacer
    }
    
    /**
     Fade to animation with duration and alpha
     - parameter duration: custom animation duration
     - parameter alpha: custom alpha value for opacity
     */
    func fadeTo(_ alpha: CGFloat, with duration: TimeInterval = 1.0) {
        DispatchQueue.main.async {
              UIView.animate(withDuration: duration) {
                self.alpha = alpha
              }
            }
    }
    
    /**
     Fade in animation with duration
     - parameter duration: custom animation duration
     */
    func fadeIn(with duration: TimeInterval = 1.0) {
        fadeTo(1.0, with: duration)
    }
    
    /**
     Fade out animation with duration
     - parameter duration: custom animation duration
     */
    func fadeOut(with duration: TimeInterval = 1.0) {
        fadeTo(0.0, with: duration)
      }
    
    static var nameOfClass: String {
        return String(describing: self)
    }
}
