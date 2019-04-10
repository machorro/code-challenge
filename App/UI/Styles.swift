//
//  Styles.swift
//  App
//
//  Copyright © 2019 Code Coding Challenge. All rights reserved.
//

import UIKit

var roundedCorners: (UIView) -> () = {
    $0.layer.cornerRadius = 6
    $0.clipsToBounds = true
}

var dropShadow: (UIView) -> () = {
    $0.backgroundColor = .clear
    $0.layer.shadowColor = UIColor.black.cgColor
    $0.layer.shadowOffset = CGSize(width: 0, height: 2.0)
    $0.layer.shadowOpacity = 0.7
    $0.layer.shadowRadius = 4.0
}

var roundView: (UIView) -> () = {
    $0.layer.cornerRadius = $0.frame.height / 2
    $0.layer.masksToBounds = true
}

extension UIColor {
    static let orangeColor = UIColor(red:0.93, green:0.44, blue:0.19, alpha:1.0)
}
