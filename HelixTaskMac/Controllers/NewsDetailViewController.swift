//
//  NewsDetailViewController.swift
//  HelixTaskMac
//
//  Created by Vahe Hakobyan on 10/15/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoStack: UIStackView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var galleryButtonsStack: UIStackView!
    @IBOutlet weak var imageGalleryButton: UIButton!
    @IBOutlet weak var videoGalleryButton: UIButton!
    
    @IBOutlet var tableViewBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Constants
    
    private let videoSegue = "VideosSegue"
    private let imageSegue = "ImagesSegue"
    
    // MARK: - Properties
    
    public var newsDetailViewModel: NewsDetailViewModel? {
        didSet (newValue) {
            if newsDetailViewModel != nil && coverImage != nil {
                refreshUI(withData: newsDetailViewModel!)
            }
//            guard let viewModelData = newValue else {
//                return
//            }
//            refreshUI(withData: viewModelData)
            
            // Force show root detail view controller (in case that collection view page or item view page has been opened)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    // MARK: - Initializing
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("\(String(describing: self)) has been loaded")
        
        // Prevent loading detail view on app start on iPhone
        if newsDetailViewModel == nil {
            if let navController = splitViewController?.viewControllers[0] as? UINavigationController {
                navController.popViewController(animated: true)
                return
            }
        }
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let newsDetailViewModel = newsDetailViewModel else {
            return
        }
        
        refreshUI(withData: newsDetailViewModel)
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        coverImage.image = UIImage(named: "placeholder")
    }
    
    private func refreshUI(withData viewModel: NewsDetailViewModel) {
        showHiddenItems()
//        let data = viewModel.data
//        print("Cover photo URL is \(viewModel.coverPhotoURL)")
        coverImage.downloadImageFrom(link: viewModel.coverPhotoURL, contentMode: .scaleAspectFit)
        titleLabel.text = viewModel.title
        categoryLabel.text = viewModel.category
        dateLabel.text = viewModel.dateLocalized
        bodyLabel.text = viewModel.body.withoutHtmlTags
        
        // Hiding buttons if there is no gallery data
        imageGalleryButton.isHidden = (viewModel.images == nil)
        videoGalleryButton.isHidden = (viewModel.videos == nil)
        
        // Scroll view management
//        let height = heightForView(text: bodyLabel.text!, font: bodyLabel.font, width: bodyLabel.frame.width)
        // Fit label height for getting correct value
        bodyLabel.sizeToFit()
//        print(bodyLabel.frame.height)
        tableViewBottomConstraint.constant = bodyLabel.frame.height + 50
        
    }
    
    private func showHiddenItems() {
        if !coverImage.isHidden {
            return
        }
        
        coverImage.isHidden = false
        titleLabel.isHidden = false
        infoStack.isHidden = false
        dateLabel.isHidden = false
        bodyLabel.isHidden = false
        galleryButtonsStack.isHidden = false
    }
    
//    private func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
//
//        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.font = font
//        label.text = text
////        label.frame.width =
//        label.sizeToFit()
//
//        return label.frame.height
//    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? GalleryCollectionViewController, let newsDetailViewModel = newsDetailViewModel {
            if segue.identifier == imageSegue {
                if let galleryItems = newsDetailViewModel.images {
                    destinationVC.galleryItems = galleryItems as [GalleryItem]
                }
                
            } else if segue.identifier == videoSegue {
                if let galleryItems = newsDetailViewModel.videos {
                    destinationVC.galleryItems = galleryItems as [GalleryItem]
                }
            }
        }
        
    }
    

}
