//
//  UIViewExtension.swift
//  DFAssesment
//
//  Created by Bharat Shilavat on 29/11/23.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(_ cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
    }
}

