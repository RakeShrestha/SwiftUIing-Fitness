//
//  ImageUploader.swift
//  SwiftUIing Fitness
//
//  Created by Rakesh Shrestha on 03/02/2025.
//


import Foundation

open class ImageUploader<Resource> {
    
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
    
    public func upload(_ imageData: Data, for boundary: String = ImageUploader.generateBoundaryString(), completion: @escaping (Result) -> Void) {
        let data = ImageUploader.createBodyWithParameters(parameters: nil, filePathKey: "file", imageDataKey: imageData, boundary: boundary, imgKey: "fileName") as Data
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
    
    private static func createBodyWithParameters(parameters: [String: String]?, filePathKey: String, imageDataKey: Data, boundary: String, imgKey: String) -> NSData {
        let body = NSMutableData()
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let fileName = "\(imgKey).jpg"
        let mimeType = "image/jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(fileName)\"\r\n")
        body.appendString(string: "Content-Type: \(mimeType)\r\n\r\n")
        body.append(imageDataKey)
        body.appendString(string: "\r\n")
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    public static func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
   
   
}

public extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
