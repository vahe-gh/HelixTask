//
//  NewsSplitViewController.swift
//  HelixTaskMac
//
//  Created by Vahe Hakobyan on 10/16/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class NewsSplitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.delegate = self
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.preferredDisplayMode = .automatic
        }
        else {
            self.preferredDisplayMode = .allVisible
        }
        
//        guard let splitViewController = sel.viewControllers?[0] as? UISplitViewController else {
//            fatalError("Missing SplitViewController")
//        }

//        guard let masterNavController = self.viewControllers.first as? UINavigationController,
//            let masterViewController = masterNavController.topViewController as? NewsTableViewController else {
//            fatalError("Missing MasterViewController")
//        }
        
//        self.delegate = masterViewController
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

//extension NewsSplitViewController: UISplitViewControllerDelegate {
//    // Does not work!!!
//    func splitViewController(_ splitViewController: UISplitViewController, show vc: UIViewController, sender: Any?) -> Bool {
//        return true
//    }
//
//    // Assuming you want that only on the first launch, but not always; for example in the case that the Master View shows an empty data set; then the solution is just as the Master-Detail template shows:
//    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
//        return true
//        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
//        guard let topAsDetailController = secondaryAsNavController.topViewController as? NewsDetailViewController else { return false }
//        if topAsDetailController.newsDetailViewModel == nil {
//            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
//            return true
//        }
//        return false
//    }
//
//}
