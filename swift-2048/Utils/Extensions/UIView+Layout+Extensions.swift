//
//  UIView+Layout+Extensions.swift
//  swift-2048
//
//  Created by joe on 08/03/23.
//

import UIKit

extension UIView {
    
    func fillInSuperView(padding: UIEdgeInsets = .zero) {
        if let superViewLeadingAnchor = superview?.leadingAnchor {
            self.leadingAnchor.constraint(equalTo: superViewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superViewTopAnchor = superview?.topAnchor {
            self.topAnchor.constraint(equalTo: superViewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superViewTrailingAnchor = superview?.trailingAnchor {
            self.trailingAnchor.constraint(equalTo: superViewTrailingAnchor, constant: -padding.right).isActive = true
        }
        
        if let superViewBottomAnchor = superview?.bottomAnchor {
            self.bottomAnchor.constraint(equalTo: superViewBottomAnchor, constant: -padding.bottom).isActive = true
        }
    }
    
    func centerInSuperView() {
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            self.centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
        }
        
        if let superViewCenterYAnchor = superview?.centerYAnchor {
            self.centerYAnchor.constraint(equalTo: superViewCenterYAnchor).isActive = true
        }
    }
    
    func centerXInSuperview() {
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
        }
    }
    
    func centerYInSuperview() {
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }

    func constraintWidth(constant: CGFloat) {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func constraintHeight(constant: CGFloat) {
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func constraintWidthAspectRatio(constant: CGFloat) {
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: constant).isActive = true
    }
    
    func constraintHeightAspectRatio(constant: CGFloat) {
        heightAnchor.constraint(equalTo: widthAnchor, multiplier: constant).isActive = true
    }
}
