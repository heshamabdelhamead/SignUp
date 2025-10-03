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
    @Published var enableSignUp : Bool = false
    private var cancellables : Set<AnyCancellable> = []
    
    private var userNameValidPublisher : AnyPublisher <Bool, Never> {
        $userName.map{!($0).isEmpty}.eraseToAnyPublisher()
    }
    private var emailValidationPublisher: AnyPublisher<String, Never> {
        $email.map(Validator.validateEmail).eraseToAnyPublisher()
    }
    private var passwordValidationPublisher: AnyPublisher<String, Never> {
        $password.map(Validator.validatePassword).eraseToAnyPublisher()
    }
    
    private var confirmPasswordValidationPublisher: AnyPublisher<String, Never> {
        Publishers.CombineLatest($password, $ConfirmPassword)
            .map { password, confirm -> String in
                Validator.validateConfirmPassword(password, confirm)
            }
            .eraseToAnyPublisher()
    }
    
    //MARK:- Init
    init() {
        bindValidation()
    }
    
    private func bindValidation() {
        userNameValidPublisher
            .map { $0 ? "" : "User Name is required" }
            .dropFirst()
            .assign(to: \.userNameError , on: self)
            .store(in: &cancellables)
        
        emailValidationPublisher
            .dropFirst()
            .assign(to: \.emailError , on: self)
            .store(in: &cancellables)
        
        passwordValidationPublisher
            .dropFirst()
            .assign(to: \.passwordError,on: self)
            .store(in: &cancellables)
        
        confirmPasswordValidationPublisher
            .dropFirst()
            .assign(to: \.ConfirmPasswordError,on: self)
            .store(in: &cancellables)
        
        Publishers.CombineLatest4(
            userNameValidPublisher,
            emailValidationPublisher.map { $0.isEmpty },
            passwordValidationPublisher.map { $0.isEmpty },
            confirmPasswordValidationPublisher.map { $0.isEmpty }
        )
        .map { $0 && $1 && $2 && $3 }
        .assign(to: &$enableSignUp)
    }
    
}




