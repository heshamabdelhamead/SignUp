//
//  SignUpView.swift
//  SignUp
//
//  Created by hesham abd elhamead on 30/09/2025.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject  var viewModel = SignUpViewModel()
    init (viewModel : SignUpViewModel){
        self.viewModel = viewModel
    }
    var body: some View {
        ZStack{
            Color.green.edgesIgnoringSafeArea(.all)
            VStack{
                Text("Sign up ")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                CredentialsView(title:$viewModel.userName , placeHolder: "User Name", errorText: $viewModel.userNameError)
                CredentialsView(title: $viewModel.email, placeHolder: "email", errorText: $viewModel.emailError, keyboardType: .emailAddress)
                CredentialsView(title: $viewModel.password, placeHolder: "password", errorText: $viewModel.passwordError, isSecure: true)
                CredentialsView(title: $viewModel.ConfirmPassword, placeHolder: "confirm password", errorText: $viewModel.ConfirmPasswordError, isSecure: true)
                
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

struct CredentialsView: View {
    @Binding var  title : String
    var placeHolder : String
    @Binding var  errorText : String
    var keyboardType : UIKeyboardType = .default
    var isSecure : Bool = false
   var body: some View {
       VStack{
           if isSecure {
               SecureField(placeHolder, text: $title)
                   .keyboardType(keyboardType)
               
                   .frame(height: 20)
                   .padding()
                   .background(Color.white)
                   .clipShape(.buttonBorder)
           }else {
               TextField( placeHolder, text: $title)
               
                   .keyboardType(keyboardType)
               
                   .frame(height: 20)
                   .padding()
                   .background(Color.white)
                   .clipShape(.buttonBorder)
           }
           Text(errorText)
               .foregroundStyle(.red)
               .frame(minWidth: 0, maxWidth: .infinity , alignment: .trailing)
               .fontWeight(.medium)
        
        
       }
    }
    
    
}
