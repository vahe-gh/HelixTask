//
//  Gallery.swift
//  HelixTaskMac
//
//  Created by Vahe on 10/14/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

struct Gallery: Codable, GalleryItem {
    let title: String
    let thumbnailURL, contentURL: String

    enum CodingKeys: String, CodingKey {
        case title
        case thumbnailURL = "thumbnailUrl"
        case contentURL = "contentUrl"
    }
}
