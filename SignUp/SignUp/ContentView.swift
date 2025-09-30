//
//  ContentView.swift
//  SignUp
//
//  Created by hesham abd elhamead on 30/09/2025.
//

import SwiftUI

struct ContentView: View {
    @State var userName : String = ""
    var userNameError : String = "Error"
    @State var email : String = ""
    var emailError : String = "Error"
    @State var password : String = ""
    var passwordError : String = "Error"
    @State var ConfirmPassword : String = ""
    var ConfirmPasswordError : String = "Error"
    var body: some View {
        ZStack{
            Color.green.edgesIgnoringSafeArea(.all)
            VStack{
                Text("Sign up ")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                CredentialsView(title: $userName, placeHolder: "User Name", errorText: userNameError)
                CredentialsView(title: $email, placeHolder: "email", errorText: emailError, keyboardType: .emailAddress)
                CredentialsView(title: $password, placeHolder: "password", errorText: emailError, isSecure: true)
                CredentialsView(title: $ConfirmPassword, placeHolder: "confirm password", errorText: emailError, isSecure: true)
                
                Button(" Sign up") {
                    print("hi")
                }
                .frame(minWidth: 0.0,  maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .clipShape(.capsule)
               // .buttonBorderShape(.buttonBorder)
            }
            .padding()
        }
        
        
    }
}

#Preview {
    ContentView()
}

struct CredentialsView: View {
    @Binding var  title : String
    var placeHolder : String
    var errorText : String
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
