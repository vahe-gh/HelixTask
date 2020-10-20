//
//  GalleryCollectionViewCell.swift
//  HelixTaskMac
//
//  Created by Vahe Hakobyan on 10/17/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    var isVideo = false {
        willSet(newValue) {
            self.contentView.subviews.last?.isHidden = !newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.contentView.addSubview(thumbnailImageView)
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor
                .constraint(equalTo: self.contentView.topAnchor),
            thumbnailImageView.leftAnchor
                .constraint(equalTo: self.contentView.leftAnchor),
            thumbnailImageView.rightAnchor
                .constraint(equalTo: self.contentView.rightAnchor),
            thumbnailImageView.bottomAnchor
                .constraint(equalTo: self.contentView.bottomAnchor),
        ])
        
        self.contentView.addSubview(playImageView)
        NSLayoutConstraint.activate([
            playImageView.centerYAnchor
                .constraint(equalTo: self.contentView.centerYAnchor),
            playImageView.centerXAnchor
                .constraint(equalTo: self.contentView.centerXAnchor),
            playImageView.widthAnchor
                .constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.3),
            playImageView.heightAnchor
                .constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.3)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        thumbnailImageView.image = nil
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "placeholder")
        return imageView
    }()
    
    let playImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "play")
        
        return view
    }()
    
}
