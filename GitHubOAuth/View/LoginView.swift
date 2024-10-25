//
//  LoginView.swift
//  GitHubOAuth
//
//  Created by Tsz-Lung on 25/10/2024.
//

import SwiftUI

struct LoginViewContainer: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        LoginView(url: viewModel.authPageURL(), message: viewModel.message, showError: $viewModel.showError)
    }
}

struct LoginView: View {
    @State private var showWebView = false
    
    let url: URL?
    let message: String?
    @Binding var showError: Bool
    
    var body: some View {
        VStack {
            Image("github")
                .resizable()
                .scaledToFit()
            
            Button("Login") {
                showWebView = url != nil && true
            }
            .font(.title3)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .foregroundStyle(.background)
            .background(.blue, in: .rect(cornerRadius: 8))
        }
        .padding()
        .alert(message ?? "", isPresented: $showError, actions: {
            Button("OK", role: .cancel) {}
        })
        .fullScreenCover(isPresented: $showWebView) {
            if let url {
                SafariWebView(url: url)
                    .ignoresSafeArea(.all)
            }
        }
    }
}

#Preview {
    LoginView(url: nil, message: nil, showError: .constant(false))
}
