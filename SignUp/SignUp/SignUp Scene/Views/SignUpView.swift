//
//  SignUpView.swift
//  SignUp
//
//  Created by hesham abd elhamead on 30/09/2025.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject  var viewModel = SignUpViewModel()
    
    init(viewModel: SignUpViewModel = SignUpViewModel()) {
           _viewModel = StateObject(wrappedValue: viewModel)
       }
    
    var body: some View {
        ZStack{
            Color.green.edgesIgnoringSafeArea(.all)
            VStack{
                Text("Sign up ")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                CredentialsView(title:$viewModel.userName , placeHolder: "User Name", errorText: viewModel.userNameError)
                CredentialsView(title: $viewModel.email, placeHolder: "email", errorText: viewModel.emailError, keyboardType: .emailAddress)
                CredentialsView(title: $viewModel.password, placeHolder: "password", errorText: viewModel.passwordError, isSecure: true)
                CredentialsView(title: $viewModel.ConfirmPassword, placeHolder: "confirm password", errorText: viewModel.ConfirmPasswordError, isSecure: true)
                Button(" Sign up") {
                    print("hi")
                }
                .disabled(!viewModel.enableSignUp)
                .frame(minWidth: 0.0,  maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background( viewModel.enableSignUp ?  .blue : .gray)
                .clipShape(.capsule)
            }
            .padding()
        }
        
        
    }
}

#Preview {
    let viewModel = SignUpViewModel()
    SignUpView(viewModel: viewModel)
}

