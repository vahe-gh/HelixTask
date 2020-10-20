//
//  NewsDetailViewModel.swift
//  HelixTaskMac
//
//  Created by Vahe Hakobyan on 10/17/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

class NewsDetailViewModel: NSObject {
    
    // MARK: - Properties
    
    private var data: News
    
    // MARK: - View model fields
    let category, title, body: String
    let shareURL: String
    let coverPhotoURL: String
    let date: Date
    let images: [Gallery]?
    let videos: [Video]?
    
    let id: String!
    public var visited: Bool
    
    var dateLocalized: String {
        return date.shortDate
    }
    
    // MARK: - Initializing methods
    
    init(withData data: News) {
        
        self.data = data
        
        category = data.category
        title = data.title
        body = data.body
        
        shareURL = data.shareURL
        coverPhotoURL = data.coverPhotoURL
        
        images = data.gallery
        videos = data.video
        
        let epocTime = TimeInterval(data.date)
        date = Date(timeIntervalSince1970: epocTime)
        
        id = data.shareURL
        visited = false
        
        super.init()
        
    }
}
