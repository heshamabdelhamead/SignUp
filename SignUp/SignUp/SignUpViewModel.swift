//
//  SignUpViewModel.swift
//  SignUp
//
//  Created by hesham abd elhamead on 01/10/2025.
//

import Foundation
import Combine

class SignUpViewModel : ObservableObject {
    @Published var userName : String = ""
    var userNameError : String = ""
    @Published var email : String = ""
    var emailError : String = ""
    @Published var password : String = ""
    var passwordError : String = ""
    @Published var ConfirmPassword : String = ""
    var ConfirmPasswordError : String = ""
    private var cancellables : Set<AnyCancellable> = []
    private var userNameValidPublisher : AnyPublisher <Bool, Never> {
        $userName
            .map{!($0).isEmpty}
            .eraseToAnyPublisher()
    }
    private var mailIsEmptyPublisher : AnyPublisher <(email:String ,isExist:Bool ), Never> {
        $email
            .map{(email : $0 , isExist : !($0).isEmpty) }
                    .eraseToAnyPublisher()
            }
    private var isValidEmailPublisher : AnyPublisher <(email : String,isValid : Bool), Never> {
        return mailIsEmptyPublisher
            .filter{$0.isExist}
            .map{(email : $0.email , isValid : ($0.email).isValideEmail())}
            .eraseToAnyPublisher()
    }
    private var passwordIsEmptyPublisher : AnyPublisher <(password: String, isExist: Bool), Never> {
        $password
            .map{(password : $0 , isExist : !($0).isEmpty)}
            .eraseToAnyPublisher()
    }
    private var passwordIsValidPublisher : AnyPublisher <Bool, Never> {
        return passwordIsEmptyPublisher
            .filter{$0.isExist}
            .map{ $0.password.isValidPassword()}
            .eraseToAnyPublisher()
    }
    private var confirmPasswordIsEmptyPublisher : AnyPublisher <(password: String, isExist: Bool), Never> {
        $ConfirmPassword
            .map{(password : $0 , isExist : !($0).isEmpty)}
            .eraseToAnyPublisher()
    }
    private var confirmPasswordIsValidPublisher: AnyPublisher<Bool, Never> {
        return   confirmPasswordIsEmptyPublisher
            .filter { $0.isExist }
            .map { [weak self] in
                guard let self = self else { return false }
                return self.password == $0.password
            }
            .eraseToAnyPublisher()
    }
    
        init() {
            userNameValidPublisher
                .receive(on: RunLoop.main)
                .dropFirst()
                .map{$0 ? "" : "UserName is required"}
                .assign(to: \.userNameError, on: self)
            
                .store(in: &cancellables)
            mailIsEmptyPublisher
                .receive(on : RunLoop.main)
                .dropFirst()
                .map {$0.email == "" ? "Email is required" : "" }
                .assign(to: \.emailError,on:self)
                .store(in: &cancellables)
            isValidEmailPublisher
                .receive(on : RunLoop.main)
                .map {$0.isValid  ? "" : "Email is not valid" }
                .assign(to: \.emailError,on:self)
                .store(in: &cancellables)
            passwordIsEmptyPublisher
                .receive(on: RunLoop.main)
                .dropFirst()
                .map {$0.password == "" ? "Password is required" : "" }
                .assign(to: \.passwordError,on:self)
                .store(in: &cancellables)
            passwordIsValidPublisher
                .receive(on: RunLoop.main)
                .map {$0 ? "" : "Password must be 6 characters long" }
                .assign(to:\.passwordError , on: self)
                .store(in: &cancellables)
            confirmPasswordIsEmptyPublisher
                .receive(on: RunLoop.main)
                .dropFirst()
                .map {$0.password == "" ? "Confirm Password is required" : "" }
                .assign(to: \.ConfirmPasswordError,on: self)
                .store(in: &cancellables)
            confirmPasswordIsValidPublisher
                .receive(on: RunLoop.main)
                .map {$0 ? "" : "Password does not match" }
                .assign(to: \.ConfirmPasswordError,on: self)
                .store(in: &cancellables)
        }
        
    }
    extension String {
        func isValideEmail() -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            return range(of: emailRegex, options: .regularExpression, range: nil, locale: nil) != nil
        }
        func isValidPassword() -> Bool {
            return count >= 6
        }
    }
