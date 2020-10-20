//
//  GalleryCollectionViewLayout.swift
//  HelixTaskMac
//
//  Created by Vahe Hakobyan on 10/17/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class GalleryCollectionViewLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        
        let numberOfCellsInRow = CGFloat(3)
        let inset = CGFloat(20)
//        let screenWidth = UIScreen.main.bounds.width
        let widthHeightConstant = UIScreen.main.bounds.width / (numberOfCellsInRow + 1) // - 2 * inset
        self.itemSize = CGSize(width: widthHeightConstant,
                               height: widthHeightConstant)
//        let numberOfCellsInRow = floor(screenWidth / widthHeightConstant)
//        let inset = (screenWidth - (numberOfCellsInRow * widthHeightConstant)) / (numberOfCellsInRow)
        self.sectionInset = .init(top: inset,
                                  left: inset,
                                  bottom: inset,
                                  right: inset)
        self.minimumInteritemSpacing = inset
        self.minimumLineSpacing = inset
        self.scrollDirection = .vertical
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
