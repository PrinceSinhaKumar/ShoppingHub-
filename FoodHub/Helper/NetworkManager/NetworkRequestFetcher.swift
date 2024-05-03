//
//  NetworkRequestFetcher.swift
//  FoodHub
//
//  Created by Priyanka Mathur on 03/05/24.
//

import Foundation

protocol NetworkRequestFetcherDelegate {
    func fetchRequest(request: URLRequest) -> URLSession.DataTaskPublisher
}

class NetworkRequestFetcher: NetworkRequestFetcherDelegate {
        
    private let session = URLSession.shared
    func fetchRequest(request: URLRequest) -> URLSession.DataTaskPublisher {
        session.dataTaskPublisher(for: request)
    }

}
