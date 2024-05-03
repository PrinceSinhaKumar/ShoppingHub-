//
//  ContentView.swift
//  FoodHub
//
//  Created by Prince Shrivastav on 11/02/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel: LoginViewModel
    @EnvironmentObject private var coordinator: NavigationCoordinatorManager<Router>

    var body: some View {
        ZStack {
            GradientView(gradientColor: [AppColor.AppOrange.color!, AppColor.AppOrange.color!]).edgesIgnoringSafeArea(.all)
            VStack() {
                Image("runningMain")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 300)
                    .shadow(radius: 4, x: 2, y: 5)
                    .padding()
            }
            
            VStack(spacing: 20) {
                Spacer()
                
                AuthFieldView(title: $viewModel.username, borderColor: $viewModel.userNameFieldBorderColor, placeHolder: "User Name", iconName: "envelope.fill")
                AuthFieldView(title: $viewModel.password, borderColor: $viewModel.passwordFieldBorderColor, placeHolder: "Password", iconName: "key.fill", isSecureField: true)
                .padding(.bottom)
                
                HStack {
                    Spacer()
                    Button("Login") {
                        viewModel.fetchLoginService()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .opacity(viewModel.isLoginEnable ? 1 : 0.5)
                    .disabled(!viewModel.isLoginEnable)
                    Spacer()
                }
                .background(Color.black)
                .cornerRadius(25)
                .padding(.horizontal)
                
            }
            .padding()
            if viewModel.isLoading {
                LoaderView()
            }
            
            if viewModel.showToastView {
                ToastView(message: $viewModel.errorMessage, showing: $viewModel.showToastView)
            }
                
        }
        .onReceive(viewModel.observeLoginSuccess()) { _ in
            coordinator.show(.mealListView)
        }
        
    }
    
    
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(model: LoginModel()))
    }
}
struct AuthFieldView: View {
    
    @Binding var title: String
    @Binding var borderColor: Color
    let placeHolder: String
    let iconName: String
    var isSecureField: Bool = false
    
    var body: some View {
        HStack(spacing: 10) {
            if isSecureField {
                SecureField(placeHolder, text: $title)
                    .padding()
                    .foregroundColor(.white)
            } else {
                TextField(placeHolder, text: $title)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.clear)
                    .autocapitalization(.none)
            }
            Image(systemName: iconName)
                .padding()
                .foregroundColor(borderColor)
        }
        .frame(height: 50)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(borderColor, lineWidth: 1)
        )
        .padding(.horizontal)
    }
    
}

//"envelope.fill"
struct ToastView: View {
    @Binding var message: String
    @Binding var showing: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.7))
                .cornerRadius(10)
                .padding()
                .opacity(showing ? 1 : 0)
                .animation(.bouncy, value: 4)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showing = false
                    message = ""
                }
            }
        }
    }
}
