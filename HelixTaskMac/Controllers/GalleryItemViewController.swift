//
//  GalleryItemViewController.swift
//  HelixTaskMac
//
//  Created by Vahe Hakobyan on 10/19/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class GalleryItemViewController: UIViewController {

    var displayItem: GalleryItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addItemSubView()
    }
    
    private func addItemSubView(){
        if let item = displayItem as? Gallery {
            let itemView = UIImageView()
            itemView.contentMode = .scaleAspectFit
            itemView.clipsToBounds = true
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.downloadImageFrom(link: item.contentURL, contentMode: .scaleAspectFill)
            
            self.view.addSubview(itemView)

            NSLayoutConstraint.activate([
                itemView.topAnchor
                    .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                itemView.leftAnchor
                    .constraint(equalTo: self.view.leftAnchor),
                itemView.rightAnchor
                    .constraint(equalTo: self.view.rightAnchor),
                itemView.bottomAnchor
                    .constraint(equalTo: self.view.bottomAnchor),
            ])
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
