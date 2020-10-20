//
//  NewsAPIResponse.swift
//  HelixTaskMac
//
//  Created by Vahe Hakobyan on 10/14/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

struct NewsAPIResponse: Codable {
    let success: Bool
    let errors, internalErrors: [String]
    let mainData: [News]

    enum CodingKeys: String, CodingKey {
        case success, errors
        case internalErrors = "internal_errors"
        case mainData = "metadata"
    }
}
