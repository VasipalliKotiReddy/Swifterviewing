//
//  API.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

class API {
    
    private var dataTask: URLSessionDataTask?
    
    //MARK: - Connecting to API
    func getAlbums(urlEndPoint: String,callback: @escaping (Result<[Any], AlbumError>) -> Void) {
        let albumsURL = AppConstants.baseURL + urlEndPoint
        print("Album URL String:",albumsURL)
        guard let url = URL(string:albumsURL) else {
            callback(.failure(.unsuppotedURL))
            return
        }
        // Create URL Session
        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle Error
            if let error = error {
                callback(.failure(.connectionError))
                print("Error: \(error.localizedDescription)")
            }
            guard let response = response as? HTTPURLResponse else {
                return
            }
            let statusCode = response.statusCode
            print("Response status code:\(statusCode)")
            guard (200...299).contains(statusCode) else {
                let albumError = self.hadlingErrorsWithStatusCode(statusCode:statusCode)
                callback(.failure(albumError))
                return
            }
            do { // handling success case
                let decoder  = JSONDecoder()
                if urlEndPoint == AppConstants.albumsEndpoint {
                    let jsonData = try decoder.decode([Album].self, from: data!)
                    DispatchQueue.main.async {
                        callback(.success(jsonData))
                    }
                }
                else if urlEndPoint == AppConstants.photosEndpoint {
                    let jsonData = try decoder.decode([Photos].self, from: data!)
                    DispatchQueue.main.async {
                        callback(.success(jsonData))
                    }
                }
            }
            catch  {
                callback(.failure(.failedToFetchData))
            }
        }
        dataTask?.resume()
        
    }
    //MARK:- Handling most common HTTP Request and Response Errors.
    func hadlingErrorsWithStatusCode(statusCode: Int) -> API.AlbumError {
        
        switch statusCode {
        case 400:
            return .invalidRequest
        case 404:
            return .dataNotFound
        case 408:
            return .timeOut
        case 500:
            return .internalServerError
        case 502:
            return .invalidResponse
        case 503:
            return .serverUnavailable
        case 520:
            return .unknownError
        default:
            return .unknownError
        }
  }
}
// MARK:- Extending the API class to write enum with error cases.
extension API {
    enum AlbumError: Error {
        case unsuppotedURL
        case connectionError
        case invalidRequest
        case invalidResponse
        case dataNotFound
        case unknownError
        case failedToFetchData
        case internalServerError
        case serverUnavailable
        case timeOut
    }
    
}
