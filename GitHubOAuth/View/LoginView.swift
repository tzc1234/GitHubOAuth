//
//  LoginView.swift
//  GitHubOAuth
//
//  Created by Tsz-Lung on 25/10/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var showWebView = false
    
    var body: some View {
        VStack {
            Image("github")
                .resizable()
                .scaledToFit()
            
            Button("Login") {
                showWebView.toggle()
            }
            .font(.title3)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .foregroundStyle(.background)
            .background(.blue, in: .rect(cornerRadius: 8))
        }
        .padding()
        .fullScreenCover(isPresented: $showWebView) {
            SafariWebView(url: URL(string: "https://www.google.com/")!)
        }
    }
}

#Preview {
    LoginView()
}
