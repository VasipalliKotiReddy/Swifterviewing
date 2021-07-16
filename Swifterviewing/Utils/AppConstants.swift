//
//  AppConstants.swift
//  Swifterviewing
//
//  Created by Koti Reddy , Vasipalli on 15/07/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import UIKit
import Foundation
struct AppConstants {
    static let baseURL = "https://jsonplaceholder.typicode.com/"
    static let photosEndpoint = "photos" //returns photos and their album ID
    static let albumsEndpoint = "albums" //returns an album, but without photos
    static let NO_INTERNET_AVAILABLE_MSG = "Please check your internet and try again."
    static let NO_INTERNET_ALERT_TITLE = "Internet is not available!"
    static let OK_BUTTON = "OK"
    static let ALERT_TITLE = "ERROR!"
    
    
    static let UNSUPPORTED_URL  = "UnSupported URL!"
    static let CONNECTION_ERROR = "A server with the specified hostname could not be found."
    static let INVALID_REQUEST  = "Invalid Request."
    static let INVALID_RESPONSE = "Invalid Response."
    static let DATA_NOT_FOUND   = "Data Not Found!"
    static let UNKNOWN_ERROR    = "Unknown Error!"
    static let FAILED_TO_FETCH_DATA = "Failed to fetch album data."
    static let INTERNAL_SERVER_ERROR = "Internal Server Error!"
    static let SERVER_UNAVAILABLE = "Server Unavailable!"
    static let REQUEST_TIMED_OUT = "Request Timed Out!"

}

