//
//  NewsViewModel.swift
//  HelixTaskMac
//
//  Created by Vahe on 10/14/20.
//  Copyright © 2020 Self. All rights reserved.
//

import Foundation

typealias Visited = [String:Bool]

class NewsViewModel: NSObject {
    
    // MARK: - Properties
    
    let defaults = UserDefaults.standard
    let visitedKey = "VisitedNews"
    
    private let apiManager: APIManager!
    private var rawData: NewsAPIResponse {
        willSet (newValue) {
            setValues(fromAPI: newValue.mainData)
        }
    }
    private (set) var data = [NewsDetailViewModel]()
    
    private var visitedList: Visited!
    
    // MARK: - Initializing methods
    
    override init() {
        apiManager = APIManager()
        rawData = NewsAPIResponse(success: true, errors: [], internalErrors: [], mainData: [News]())
        
        super.init()
        
        visitedList = getVisitedList()
    }
    
    // MARK: - Public methods
    
    public func fetchData(completion: @escaping (NewsAPIResponse?, String?) -> Void) {
        apiManager.fetchNews { [weak self] (response, error) in
            if let response = response {
                self?.rawData = response
                completion(response, nil)
            }
            completion(response, error)
        }
    }
    
    public func setAsVisited(index: Int) {
        data[index].visited = true
        visitedList[data[index].id] = true
        
        saveVisitedList()
    }
    
    // MARK: - Private methods
    
    private func setValues(fromAPI data: [News]) {
        for item in data {
            let viewModelData = NewsDetailViewModel(withData: item)
            if visitedList.keys.contains(viewModelData.id) {
                viewModelData.visited = true
            }
            self.data.append(viewModelData)
        }
    }
    
    private func getVisitedList() -> Visited {
        return defaults.object(forKey: visitedKey) as? Visited ?? Visited()
    }
    
    private func saveVisitedList() {
        defaults.set(visitedList, forKey: visitedKey)
    }
    
}
