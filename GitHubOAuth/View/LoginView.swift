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
        LoginView(url: viewModel.authPageURL(), errorMessage: viewModel.errorMessage)
    }
}

struct LoginView: View {
    @State private var showWebView = false
    @State private var showAlert = false
    
    let url: URL?
    let errorMessage: String?
    
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
        .alert(errorMessage ?? "", isPresented: $showAlert, actions: {
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
    LoginView(url: nil, errorMessage: nil)
}
