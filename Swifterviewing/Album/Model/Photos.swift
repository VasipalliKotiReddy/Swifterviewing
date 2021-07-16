//
//  Photos.swift
//  Swifterviewing
//
//  Created by Koti Reddy , Vasipalli on 15/07/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import Foundation

struct Photos: Decodable {
    let albumId: Int?
    let id: Int?
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}

