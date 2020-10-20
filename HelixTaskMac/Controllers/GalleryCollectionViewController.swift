//
//  GalleryCollectionViewController.swift
//  HelixTaskMac
//
//  Created by Vahe Hakobyan on 10/17/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit



class GalleryCollectionViewController: UICollectionViewController {    
    
    // Used for NSCache
    private let cache = NSCache<NSNumber, UIImage>()
    
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    
    // MARK: - Identifiers
    private let viewCellReuseIdentifier = "ThumbnailCell"
    private let displayItemSegueIdentifier = "GalleryItemSegue"
    private let displayVIdeoItemSegueIdentifier = "VideoItemSegue"
    
    // MARK: - Constants
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    
    // MARK: - Data
    var galleryItems = [GalleryItem]()
    private var isVideoCollection = false
    
    // MARK: - Initializing
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(type(of: galleryItems))
        isVideoCollection = true

//        generateTempData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: viewCellReuseIdentifier)
        
        // Set ViewLayout for displaying fixed count items per row
        self.collectionView.collectionViewLayout = GalleryCollectionViewLayout()
    }
    
    // MARK: - Private functions
    
    private func loadImage(forItem index: Int, completion: @escaping (UIImage?) -> ()) {
        utilityQueue.async {
          
            let url = URL(string: self.galleryItems[index].thumbnailURL)!

            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)

            DispatchQueue.main.async {
                completion(image)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return galleryItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewCellReuseIdentifier, for: indexPath) as! GalleryCollectionViewCell
        
        if let _ = self.galleryItems[indexPath.item] as? Video {
            cell.isVideo = true
        } else {
            cell.isVideo = false
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        guard let cell = cell as? GalleryCollectionViewCell else { return }

//        let itemNumber = NSNumber(value: indexPath.item)
        let image = UIImage()
        let imageURL = galleryItems[indexPath.item].thumbnailURL
        if let image = image.downloadFromOfflineStorage(link: imageURL) {
            // Loaded from local storage
            cell.thumbnailImageView.image = image
        } else {
            self.loadImage(forItem: indexPath.item) { (image) in
                guard let image = image else { return }

                cell.thumbnailImageView.image = image
                image.saveToOfflineStorage(withPath: imageURL)
                // For NSCache
//                self.cache.setObject(image, forKey: itemNumber)
            }
        }
        // For NSCache
//        if let cachedImage = self.cache.object(forKey: itemNumber) {
//            print("Using a cached image for item: \(itemNumber)")
//            cell.thumbnailImageView.image = cachedImage
//        } else {
//            self.loadImage(forItem: indexPath.item) { [weak self] (image) in
//                guard let self = self, let image = image else { return }
//
//                cell.thumbnailImageView.image = image
//                self.cache.setObject(image, forKey: itemNumber)
//            }
//        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        if let _ = galleryItems[indexPath.item] as? Video {
            self.performSegue(withIdentifier: displayVIdeoItemSegueIdentifier, sender: cell)
        } else if let _ = galleryItems[indexPath.item] as? Gallery {
            self.performSegue(withIdentifier: displayItemSegueIdentifier, sender: cell)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == displayItemSegueIdentifier, let destinationVC = segue.destination as? GalleryItemViewController {
            if let cell = sender as? GalleryCollectionViewCell, let indexPath = collectionView.indexPath(for: cell) {
                let displayItem = galleryItems[indexPath.item]
                destinationVC.displayItem = displayItem
            }
        } else if segue.identifier == displayVIdeoItemSegueIdentifier, let destinationVC = segue.destination as? GalleryVideoViewController {
            if let cell = sender as? GalleryCollectionViewCell, let indexPath = collectionView.indexPath(for: cell) {
                let displayItem = galleryItems[indexPath.item]
                destinationVC.displayItem = displayItem
            }
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
