//
//  SignUpApp.swift
//  SignUp
//
//  Created by hesham abd elhamead on 30/09/2025.
//

import SwiftUI

@main
struct SignUpApp: App {
    var body: some Scene {
        let viewModel = SignUpViewModel()
        WindowGroup {
            SignUpView(viewModel: viewModel)
        }
    }
}
