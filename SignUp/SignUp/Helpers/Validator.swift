//
//  Validator.swift
//  SignUp
//
//  Created by hesham abd elhamead on 03/10/2025.
//


enum Validator {
    static func validateEmail(_ email: String) -> String {
        if email.isEmpty { return "Email is required" }
        if !email.isValidEmail() { return "Email is not valid" }
        return ""
    }
    
    static func validatePassword(_ password: String) -> String {
        if password.isEmpty { return "Password is required" }
        if password.count < 6 { return "Password must be 6 characters long" }
        return ""
    }
    
    static func validateConfirmPassword(_ password: String, _ confirm: String) -> String {
        if confirm.isEmpty { return "Confirm Password is required" }
        if confirm != password { return "Password does not match" }
        return ""
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return range(of: emailRegex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
