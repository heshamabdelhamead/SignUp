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
    @Published var userNameError : String = ""
    @Published var email : String = ""
    @Published var emailError : String = ""
    @Published var password : String = ""
    @Published var passwordError : String = ""
    @Published var ConfirmPassword : String = ""
    @Published var ConfirmPasswordError : String = ""
    @Published var enableSignUp : Bool = false
    private var cancellables : Set<AnyCancellable> = []
   
    private var userNameValidPublisher : AnyPublisher <Bool, Never> {
        $userName
            .map{!($0).isEmpty}
            .eraseToAnyPublisher()
    }
    private var mailRequiredPublisher : AnyPublisher <(email:String ,isExist:Bool ), Never> {
        $email
            .map{(email : $0 , isExist : !($0).isEmpty) }
                    .eraseToAnyPublisher()
            }
    private var mailValidPublisher : AnyPublisher <(email : String,isValid : Bool), Never> {
        return mailRequiredPublisher
            .filter{$0.isExist}
            .map{(email : $0.email , isValid : ($0.email).isValidEmail())}
            .eraseToAnyPublisher()
    }
    private var passwordRequiredPublisher : AnyPublisher <(password: String, isExist: Bool), Never> {
        $password
            .map{(password : $0 , isExist : !($0).isEmpty)}
            .eraseToAnyPublisher()
    }
    private var passwordValidPublisher : AnyPublisher <Bool, Never> {
        return passwordRequiredPublisher
            .filter{$0.isExist}
            .map{ $0.password.isValidPassword()}
            .eraseToAnyPublisher()
    }
    private var confirmPasswordRequiredPublisher : AnyPublisher <(password: String, isExist: Bool), Never> {
        $ConfirmPassword
            .map{(password : $0 , isExist : !($0).isEmpty)}
            .eraseToAnyPublisher()
    }
    private var confirmPasswordValidPublisher: AnyPublisher<Bool, Never> {
        return   confirmPasswordRequiredPublisher
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
            mailRequiredPublisher
                .receive(on : RunLoop.main)
                .dropFirst()
                .map {$0.email == "" ? "Email is required" : "" }
                .assign(to: \.emailError,on:self)
                .store(in: &cancellables)
            mailValidPublisher
                .receive(on : RunLoop.main)
                .map {$0.isValid  ? "" : "Email is not valid" }
                .assign(to: \.emailError,on:self)
                .store(in: &cancellables)
            passwordRequiredPublisher
                .receive(on: RunLoop.main)
                .dropFirst()
                .map {$0.password == "" ? "Password is required" : "" }
                .assign(to: \.passwordError,on:self)
                .store(in: &cancellables)
            passwordValidPublisher
                .receive(on: RunLoop.main)
                .map {$0 ? "" : "Password must be 6 characters long" }
                .assign(to:\.passwordError , on: self)
                .store(in: &cancellables)
            confirmPasswordRequiredPublisher
                .receive(on: RunLoop.main)
                .dropFirst()
                .map {$0.password == "" ? "Confirm Password is required" : "" }
                .assign(to: \.ConfirmPasswordError,on: self)
                .store(in: &cancellables)
            confirmPasswordValidPublisher
                .receive(on: RunLoop.main)
                .map {$0 ? "" : "Password does not match" }
                .assign(to: \.ConfirmPasswordError,on: self)
                .store(in: &cancellables)
            
            Publishers.CombineLatest4(userNameValidPublisher , mailValidPublisher, passwordValidPublisher, confirmPasswordValidPublisher)
                .receive(on: RunLoop.main)
                .map { name ,m , pass, Confirm in
                    return name && m.isValid && pass && Confirm
                }
                .assign(to: \.enableSignUp, on: self)
                .store(in: &cancellables)
        }
        
    }
    extension String {
        func isValidEmail() -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            return range(of: emailRegex, options: .regularExpression, range: nil, locale: nil) != nil
        }
        func isValidPassword() -> Bool {
            return count >= 6
        }
    }
