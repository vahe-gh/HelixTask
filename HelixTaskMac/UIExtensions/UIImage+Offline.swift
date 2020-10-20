//
//  UIImage+Offline.swift
//  HelixTaskMac
//
//  Created by Vahe Hakobyan on 10/20/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

extension UIImage {
    func downloadFromOfflineStorage(link: String) -> UIImage? {
        if let imageData = UserDefaults.standard.object(forKey: getImagePath(link: link)) as? Data,
            let image = UIImage(data: imageData) {
            return image
        }
        return nil
    }
    
    func saveToOfflineStorage(withPath link: String) {
        if let pngRepresentation = self.pngData() {
            UserDefaults.standard.set(pngRepresentation,
                                                forKey: getImagePath(link: link))
        }
    }
    
    private func getImagePath(link: String) -> String {
        return "\(link)"
    }
}
