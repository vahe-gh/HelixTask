//
//  APIManager.swift
//  HelixTaskMac
//
//  Created by Vahe on 10/14/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

class APIManager: NSObject {
    private struct apiURLs {
        static let news = "https://www.helix.am/temp/json.php"
    }
    
    private let offlineDataKey = "offlineAPIResponse"
    
    public func fetchNews(completion: @escaping (NewsAPIResponse?, String?) -> Void) {
        
        guard let url = URL(string: apiURLs.news) else {
            completion(nil, "Wrong URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, urlResponse, error) in
            if let rawData = data {
                do {
                    let data = try JSONDecoder().decode(NewsAPIResponse.self, from: rawData)
                    self?.saveJSON(jsonData: rawData)
                    completion(data, nil)
                    return
                } catch {
//                    completion(nil, error.localizedDescription)
                }
            }
            if let rawData = self?.loadJSON() {
                do {
                    let data = try JSONDecoder().decode(NewsAPIResponse.self, from: rawData)
                    completion(data, nil)
                    return
                } catch {
                    completion(nil, "There is no any data")
                    return
                }
            }
        }.resume()
        
    }
    
    // MARK: - Offline mode functionality
    
    private func saveJSON(jsonData: Data) {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                             in: .userDomainMask).first {
            let pathWithFileName = documentDirectory.appendingPathComponent(offlineDataKey)
            do {
                try jsonData.write(to: pathWithFileName)
            } catch let error {
                print("Saving data resulted in error: ", error)
            }
        }
    }
    
    private func loadJSON() -> Data? {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pathWithFileName = documentDirectory.appendingPathComponent(offlineDataKey)
            return try? Data(contentsOf: URL(fileURLWithPath: pathWithFileName.path))
        }
        return nil
    }
}
