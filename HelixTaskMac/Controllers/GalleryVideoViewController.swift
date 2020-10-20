//
//  GalleryVideoViewController.swift
//  HelixTaskMac
//
//  Created by Vahe Hakobyan on 10/19/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit
import WebKit

class GalleryVideoViewController: UIViewController {
    @IBOutlet weak var videoView: WKWebView!
    
    var displayItem: GalleryItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let contentURL = displayItem?.contentURL else { return }
        let url = URL(string: "https://www.youtube.com/watch?v=\(contentURL)&autoplay=1")
        let urlRequest = URLRequest(url: url!)
        videoView.load(urlRequest)
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
