//
//  LoginViewModel.swift
//  FoodHub
//
//  Created by Priyanka Mathur on 03/05/24.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    
    let model: LoginModel
    
    @Published var username: String = ""
    @Published var userNameFieldBorderColor:Color = .white
    @Published var password: String = ""
    @Published var passwordFieldBorderColor:Color = .white
    @Published var errorMessage: String = ""
    
    private var cancellable = Set<AnyCancellable>()
    
    private var userNamePublisher: AnyPublisher<Bool, Never> {
        return $username
            .map{ !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    private var passwordPublisher: AnyPublisher <Bool, Never> {
        return $password
            .map{ !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    @Published var isLoading: Bool = false
    @Published var showToastView: Bool = false
    private let loginSuccessPublisher = PassthroughSubject<Void, Never>()
    
    init(model: LoginModel) {
        self.model = model
        userNamePublisher
            .receive(on: DispatchQueue.main)
            .map { $0 ? .white : .red }
            .assign(to: \.userNameFieldBorderColor, on: self)
            .store(in: &cancellable)
        passwordPublisher
            .receive(on: DispatchQueue.main)
            .map({ $0 ? .white : .red })
            .assign(to: \.passwordFieldBorderColor, on: self)
            .store(in: &cancellable)
    }
    
    var isLoginEnable: Bool {
        return !(username.isEmpty || password.isEmpty)
    }
    
    func fetchLoginService() {
        isLoading.toggle()
        model.apiContainer = .init(username: username, password: password)
        model.fetchData()
            .sink { completion in
                if case .failure(let error) = completion {
                    self.showToastView.toggle()
                    self.errorMessage = error.description
                    self.isLoading.toggle()
                }
            } receiveValue: { data in
                if data.token == nil {
                    self.errorMessage = data.reason ?? ""
                    self.showToastView.toggle()
                } else {
                    self.loginSuccessPublisher.send()
                }
                self.isLoading.toggle()
            }
            .store(in: &cancellable)
    }
    
    // Publisher to observe successful login
    func observeLoginSuccess() -> AnyPublisher<Void, Never> {
        loginSuccessPublisher.eraseToAnyPublisher()
    }
}
