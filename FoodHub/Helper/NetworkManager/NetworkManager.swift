//
//  NetworkManager.swift
//  FoodHub
//
//  Created by Priyanka Mathur on 03/05/24.
//

import Combine
import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    fileprivate let requestMaker: RequestMakerDelegate
    fileprivate let requestFetcher: NetworkRequestFetcherDelegate
    
    private init(requestMaker: RequestMakerDelegate = RequestMaker(),
         requestFetcher: NetworkRequestFetcherDelegate = NetworkRequestFetcher())
    {
        self.requestMaker = requestMaker
        self.requestFetcher = requestFetcher
    }
    
    func fetchNetworkRequest<D: Decodable>( from endpoint: ApiEndpoint,
                                            body: Encodable? = nil) ->  AnyPublisher<D, ApiError>? {
        
        guard let request = requestMaker.createRequest(endpoint: endpoint,
                                                       body: body) else {
            return nil
        }
        
       return requestFetcher.fetchRequest(request: request)
            .map(\.data)
            .decode(type: D.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .mapError { error in
                ApiError.parseError
            }
            .eraseToAnyPublisher()
        
    }
    
}

