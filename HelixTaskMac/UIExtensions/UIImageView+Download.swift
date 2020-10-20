//
//  UIImageView+Download.swift
//  HelixTaskMac
//
//  Created by Vahe on 10/15/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

extension UIImageView {
    
    // Check if contentMode is necessary in project
    func downloadImageFrom(link: String, contentMode: UIView.ContentMode) {
        let image = UIImage()
        if let image = image.downloadFromOfflineStorage(link: link) {
            self.image = image
        } else {
            URLSession.shared.dataTask(with: URL(string:link)!, completionHandler: {
                [weak self](data, response, error) -> Void in
                DispatchQueue.main.async {
    //                self.contentMode =  contentMode
                    if let data = data, let image = UIImage(data: data) {
                        self?.image = image
                        image.saveToOfflineStorage(withPath: link)
                    }
                }

            }).resume()
        }
    }

}
