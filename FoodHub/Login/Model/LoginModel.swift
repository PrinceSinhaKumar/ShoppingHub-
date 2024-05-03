//
//  LoginModel.swift
//  FoodHub
//
//  Created by Priyanka Mathur on 03/05/24.
//

import Foundation
import Combine

protocol ModelDelegate {
    associatedtype D
    associatedtype E
    var data: D? { get set }
    var apiContainer:E? {get set}
    var cancellable: Set<AnyCancellable> { get set }
    func fetchData() -> AnyPublisher<D, ApiError>
}

class LoginModel: ModelDelegate {
    var data: LoginModelDecodable?
    var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    var apiContainer: LoginModelEncodable?

    func fetchData() -> AnyPublisher<LoginModelDecodable, ApiError> {
        if let publisher = NetworkManager.shared.fetchNetworkRequest(from: .getLoginContent, body: apiContainer) as AnyPublisher<LoginModelDecodable, ApiError>? {
            return publisher
                .handleEvents(receiveOutput: { [weak self] result in
                    self?.data = result
                })
                .eraseToAnyPublisher()
        }
        return Fail(error: .parseError).eraseToAnyPublisher()
    }
}
