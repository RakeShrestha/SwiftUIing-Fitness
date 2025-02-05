//
//  URLSessionHTTPClient.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 03/02/2025.
//

import Foundation

public class URLSessionHTTPClient: HTTPClient {
    
    private let session: URLSession
    
    struct UnexpectedValuesRepresentation: Error {}
    private var observation: NSKeyValueObservation?
    
    deinit {
        observation?.invalidate()
    }
    
    public init(session: URLSession = .shared) {
        self.session = session
        self.session.configuration.timeoutIntervalForRequest  = 120
    }
    
    private func startTask(with request: URLRequest, completion: @escaping(HTTPClient.Result) -> Void, progressMade: ((Double) -> Void)?) {
        
        let task =   session.dataTask(with: request) { data, response, error  in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success((data, response)))
            } else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }
        observation = task.progress.observe(\.fractionCompleted) { progress, _ in
            progressMade?(progress.fractionCompleted)
        }
        task.resume()
    }
    
    public func get(from url: URL, token: String? = nil, completion: @escaping(HTTPClient.Result) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request = URLSessionHTTPClient.requestAddingHeaders(to: request)
        
        if let token = token {
            request = URLSessionHTTPClient.requestAddingTokenHeaders(to: request, token: token)
        }
        
        startTask(with: request, completion: completion, progressMade: nil)
    }
    
    public func upload(_ data: Data, token: String? = nil, with boundary: String, to url: URL, completion: @escaping (HTTPClient.Result) -> Void, progressMade: @escaping (Double) -> Void) {
        var request = URLSessionHTTPClient.multiPartRequestWithHeader(for: url, data: data, boundary: boundary)
        request.httpBody = data
        request = URLSessionHTTPClient.requestAddingHeaders(to: request)
        if let token = token {
            request = URLSessionHTTPClient.requestAddingTokenHeaders(to: request, token: token)
        } else  {
            return
        }
        
        startTask(with: request, completion: completion, progressMade: progressMade)
    }
    
    public func post(_ data: Data, to url: URL, token: String? = nil, completion: @escaping (HTTPClient.Result) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request = URLSessionHTTPClient.requestAddingHeaders(to: request)
        
        if let token = token {
            request = URLSessionHTTPClient.requestAddingTokenHeaders(to: request, token: token)
        }
        
        startTask(with: request, completion: completion, progressMade: nil)
    }
    
    public func post( to url: URL, token: String? = nil, completion: @escaping (HTTPClient.Result) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request =  URLSessionHTTPClient.requestAddingHeaders(to: request)
        
        if let token = token {
            request = URLSessionHTTPClient.requestAddingTokenHeaders(to: request, token: token)
        }else  {
            return
        }
        
        startTask(with: request, completion: completion, progressMade: nil)
    }
    
    public func patch(to url: URL, token: String?, completion: @escaping (HTTPClient.Result) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request =  URLSessionHTTPClient.requestAddingHeaders(to: request)
        
        if let token = token {
            request = URLSessionHTTPClient.requestAddingTokenHeaders(to: request, token: token)
        } else  {
            return
        }
        
        startTask(with: request, completion: completion, progressMade: nil)
    }
    
    public func patch(to url: URL, data: Data, token: String?, completion: @escaping (HTTPClient.Result) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.httpBody = data
        request =  URLSessionHTTPClient.requestAddingHeaders(to: request)
        
        if let token = token {
            request = URLSessionHTTPClient.requestAddingTokenHeaders(to: request, token: token)
        } else  {
            return
        }
        
        startTask(with: request, completion: completion, progressMade: nil)
    }
    public func put(to url: URL, data: Data, token: String?, completion: @escaping (HTTPClient.Result) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = data
        request =  URLSessionHTTPClient.requestAddingHeaders(to: request)
        
        if let token = token {
            request = URLSessionHTTPClient.requestAddingTokenHeaders(to: request, token: token)
        }else  {
            return
        }
        
        startTask(with: request, completion: completion, progressMade: nil)
    }
    
    public func put(to url: URL, token: String?, completion: @escaping (HTTPClient.Result) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request =  URLSessionHTTPClient.requestAddingHeaders(to: request)
        
        if let token = token {
            request = URLSessionHTTPClient.requestAddingTokenHeaders(to: request, token: token)
        } else  {
            return
        }
        
        startTask(with: request, completion: completion, progressMade: nil)
    }
    
    public func delete(to url: URL, token: String?, completion: @escaping (HTTPClient.Result) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request =  URLSessionHTTPClient.requestAddingHeaders(to: request)
        
        if let token = token {
            request = URLSessionHTTPClient.requestAddingTokenHeaders(to: request, token: token)
        } else  {
            return
        }
        
        startTask(with: request, completion: completion, progressMade: nil)
    }
    
    public func delete(to url: URL, data: Data, token: String?, completion: @escaping (HTTPClient.Result) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.httpBody = data
        request =  URLSessionHTTPClient.requestAddingHeaders(to: request)
        if let token = token {
            request = URLSessionHTTPClient.requestAddingTokenHeaders(to: request, token: token)
        } else  {
            return
        }
        startTask(with: request, completion: completion, progressMade: nil)
    }
    
    
    private static func multiPartRequestWithHeader(for url: URL, data: Data, boundary: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    private static func requestAddingHeaders(to request: URLRequest) -> URLRequest {
        var request = request
        request.addValue("*/*", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private static func requestAddingTokenHeaders(to request: URLRequest, token: String) -> URLRequest {
        var request = request
        request.addValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
   
}
