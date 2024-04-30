//
//  ContentView.swift
//  FoodHub
//
//  Created by Prince Shrivastav on 11/02/24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username = ""
    @State private var password = ""
    
    var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            GradientView(gredientColor: [AppColor.AppOrange.color!, AppColor.AppOrange.color!]).edgesIgnoringSafeArea(.all)
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
                HStack(spacing: 10) {
                    TextField("Username", text: $username)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.clear)
                        .autocapitalization(.none)
                    Image(systemName: "envelope.fill")
                        .padding()
                        .foregroundColor(.white)
                }
                .frame(height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 1)
                )
                .padding(.horizontal)
                
                HStack(spacing: 10) {
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .foregroundColor(.white)
                    
                    Image(systemName: "key.fill")
                        .padding()
                        .foregroundColor(.white)
                }
                .frame(height: 50)
                .overlay {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 1)
                }
                .padding(.horizontal)
                .padding(.bottom)
                HStack {
                    Spacer()
                    Button("Login") {
                        viewModel.fetchLogin(loginData: LoginModelEncodable(username: username, password: password))
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(height: 50)
                    Spacer()
                }
                .background(Color.black)
                .cornerRadius(25)
                .padding(.horizontal)
                
            }
            .padding()
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(model: LoginModel(), reloadFoodModel: ReloadFoodModel()))
    }
}
