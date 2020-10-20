//
//  NewsTableViewCell.swift
//  HelixTaskMac
//
//  Created by Vahe on 10/14/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var viewModel: NewsDetailViewModel? {
        willSet (newValue) {
            guard let cellData = newValue else {
//                print("Cell type convertion has failed!")
                // print("Data is \(String.init(describing: newValue))")
                return
            }
            titleLabel.text = cellData.title
            categoryLabel.text = cellData.category
            dateLabel.text = cellData.dateLocalized
            coverImage.downloadImageFrom(link: cellData.coverPhotoURL, contentMode: .scaleAspectFit)
            
            backgroundColor = cellData.visited ? Theme.Colors.visitedCellBackgroundColor : UIColor.clear
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        coverImage.layer.cornerRadius = 10
        coverImage.clipsToBounds = true
        coverImage.image = UIImage(named: "placeholder")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
