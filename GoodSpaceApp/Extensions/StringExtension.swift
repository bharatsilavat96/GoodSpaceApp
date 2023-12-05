//
//  StringExtension.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 05/12/23.
//

import Foundation
import UIKit

extension String {
    func colored(with color: UIColor, for searchString: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        
        // Find the range of the searchString in the original string
        let range = (self as NSString).range(of: searchString, options: .caseInsensitive)
        
        // Apply color to the found range
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        
        return attributedString
    }
}
