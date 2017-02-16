//
//  UIView+Contrainer.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 2/16/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraints(toFillSuperView superView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(0)-[subview]-(0)-|",
                                                                                options: NSLayoutFormatOptions(rawValue:0),
                                                                                metrics: nil,
                                                                                views: ["subview" : self]))
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[subview]-(0)-|",
                                                                                options: NSLayoutFormatOptions(rawValue:0),
                                                                                metrics: nil,
                                                                                views: ["subview" : self]))
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
