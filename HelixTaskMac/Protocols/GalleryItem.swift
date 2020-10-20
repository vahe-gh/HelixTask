//
//  GalleryItem.swift
//  HelixTaskMac
//
//  Created by Vahe Hakobyan on 10/17/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

// Common type for both image and video
protocol GalleryItem {
    var thumbnailURL: String { get }
    var contentURL: String { get }
}
