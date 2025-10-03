//
//  CredentialsView.swift
//  SignUp
//
//  Created by hesham abd elhamead on 03/10/2025.
//

import SwiftUI

struct CredentialsView: View {
    @Binding var  title : String
    var placeHolder : String
    var  errorText : String
    var keyboardType : UIKeyboardType = .default
    var isSecure : Bool = false
    var body: some View {
        VStack{
            Group {
                if isSecure {
                    SecureField(placeHolder, text: $title)
                        .keyboardType(keyboardType)
                    
                }else {
                    TextField( placeHolder, text: $title)
                        .keyboardType(keyboardType)
                }
            }
            .frame(height: 20)
            .padding()
            .background(Color.white)
            .clipShape(.buttonBorder)
            if !errorText.isEmpty{
                Text(errorText)
                    .foregroundStyle(.purple)
                    .frame(minWidth: 0, maxWidth: .infinity , alignment: .trailing)
                    .font(.caption)
            }
            
        }
    }
}
