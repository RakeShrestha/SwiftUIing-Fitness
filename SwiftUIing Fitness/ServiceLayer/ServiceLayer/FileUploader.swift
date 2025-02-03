//
//  FileUploader.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 03/02/2025.
//

import Foundation

open class FileUploader<Resource> {
    
    public typealias Result = Swift.Result<Resource, Swift.Error>
    public typealias Mapper = (Data, HTTPURLResponse, String) throws -> Resource
    
    private let client: HTTPClient
    private let url: URL
    private let token: String?
    var mapper: Mapper
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public init(client: HTTPClient, url: URL, mapper: @escaping Mapper, token: String?) {
        self.client = client
        self.url = url
        self.mapper = mapper
        self.token = token
    }
    
    public func upload(_ fileData: Data, for boundary: String = FileUploader.generateBoundaryString(), fileName: String, mimeType: String, completion: @escaping (Result) -> Void) {
        let data = FileUploader.createBodyWithParameters(parameters: nil, filePathKey: "file", fileData: fileData, boundary: boundary, fileKey: "fileName", fileName: fileName, mimeType: mimeType) as Data
        client.upload(data, token: token, with: boundary, to: url) { result in
            switch result {
            case let .success((data, response)):
                do {
                    let resource  = try self.mapper(data, response, boundary)
                    completion(.success(resource))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure:
                completion(.failure(Error.connectivity))
            }
        } progressMade: { progress in
            print(progress)
        }
        
    }
    
    private static func createBodyWithParameters(parameters: [String: String]?, filePathKey: String, fileData: Data, boundary: String, fileKey: String, fileName: String, mimeType: String) -> NSData {
        let body = NSMutableData()
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let fileName = "\(fileName)"
        let mimeType = mimeType
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(fileName)\"\r\n")
        body.appendString(string: "Content-Type: \(mimeType)\r\n\r\n")
        body.append(fileData)
        body.appendString(string: "\r\n")
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    public static func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
}
