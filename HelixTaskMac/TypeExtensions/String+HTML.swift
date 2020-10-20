//
//  String+HTML.swift
//  HelixTaskMac
//
//  Created by Vahe Hakobyan on 10/20/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

extension String {
    var withoutHtmlTags: String {
      return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
