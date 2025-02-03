//
//  RemoteLoader.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 03/02/2025.
//

import Foundation

open class RemoteLoader<Resource> {
    public typealias Result = Swift.Result<Resource, Swift.Error>
    public typealias Mapper = (Data, HTTPURLResponse) throws -> Resource
    
    private let client: HTTPClient
    private let url: URL
    private let token: String?
    var mapper: Mapper
    
    public init(client: HTTPClient, url: URL, mapper: @escaping Mapper, token: String?) {
        self.client = client
        self.url = url
        self.mapper = mapper
        self.token = token
    }
    
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url, token: token) { result in
            switch result {
            case .failure:
                completion(.failure(CustomError.connectivity))
            case let .success((data, response)):
                do {
                    let resource = try self.mapper(data, response)
                    completion(.success(resource))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    public func load(pathParam: String, completion: @escaping (Result) -> Void) {
        let urlWithPathParam = URL(string: url.absoluteString + "\(pathParam.replacingOccurrences(of: "<p>", with: ""))")!
        client.get(from: urlWithPathParam, token: token) { result in
            switch result {
            case .failure:
                completion(.failure(CustomError.connectivity))
            case let .success((data, response)):
                do {
                    let resource = try self.mapper(data, response)
                    completion(.success(resource))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
}
