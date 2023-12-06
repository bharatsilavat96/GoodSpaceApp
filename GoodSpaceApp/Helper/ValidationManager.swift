//
//  ValidationManager.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 05/12/23.
//

import Foundation

class ValidationManager {
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    static func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneRegex = #"^(\+91|0)?[6789]\d{9}$"#
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phoneNumber)
    }
}

