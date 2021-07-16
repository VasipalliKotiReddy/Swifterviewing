//
//  AlbumViewModel.swift
//  Swifterviewing
//
//  Created by Koti Reddy , Vasipalli on 15/07/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import Foundation

class AlbumViewModel {
    var api = API()
    var albums = [Album]()
    var albumsPhotos = [Photos]()
    var groupAlbumsByAlbumId =  [Int: [Photos]]()
    
    func fetchAlbumData(urlEndPoint: String,completion: @escaping (Bool, String?) -> Void) {
        
        api.getAlbums(urlEndPoint: urlEndPoint, callback: {[weak self] (result)  in
            switch result {
            case .success(let albumArray):
                if urlEndPoint == AppConstants.albumsEndpoint {
                    self?.albums = (albumArray as? [Album])!
                } else if urlEndPoint == AppConstants.photosEndpoint {
                    self?.albumsPhotos = (albumArray as? [Photos])!
                    self!.groupAlbumsByAlbumId = Dictionary(grouping: self!.albumsPhotos, by: {$0.albumId!})
                }
                completion(true,nil)
            case .failure(let error):
                print("Error data:\(error)")
                let errorString = self!.handlingErrors(error:error)
                completion(false,errorString)
            }
        })
    }
    
    func handlingErrors(error:API.AlbumError) -> String{
          switch error {
          case .unsuppotedURL:
              print("Unsupported URL!")
              return AppConstants.UNSUPPORTED_URL
          case .connectionError:
              print("Connection Error!")
              return AppConstants.CONNECTION_ERROR
          case .invalidRequest:
              print("Invalid Request!")
              return AppConstants.INVALID_REQUEST
          case .invalidResponse:
              print("Invalid Response.")
              return AppConstants.INVALID_RESPONSE
          case .dataNotFound:
              print("Data Not Found")
              return AppConstants.DATA_NOT_FOUND
          case .unknownError:
              print("Unknown Error!")
              return AppConstants.UNKNOWN_ERROR
          case .failedToFetchData:
              print("It is failed to fetch album data currenly.")
              return AppConstants.FAILED_TO_FETCH_DATA
          case .internalServerError:
              print("Internal Server Error!")
              return AppConstants.INTERNAL_SERVER_ERROR
          case .serverUnavailable:
              print("Server Unavailable")
              return AppConstants.SERVER_UNAVAILABLE
          case .timeOut:
              print("Request Timed Out!")
              return AppConstants.REQUEST_TIMED_OUT
        }
          
      }
    
}

