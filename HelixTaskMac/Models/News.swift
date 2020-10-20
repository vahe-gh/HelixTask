//
//  News.swift
//  HelixTaskMac
//
//  Created by Vahe on 10/14/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

struct News: Codable {
    let category, title, body: String
    let shareURL, coverPhotoURL: String
    let date: Int
    let gallery: [Gallery]?
    let video: [Video]?

    enum CodingKeys: String, CodingKey {
        case category, title, body
        case shareURL = "shareUrl"
        case coverPhotoURL = "coverPhotoUrl"
        case date, gallery, video
    }
    
}
