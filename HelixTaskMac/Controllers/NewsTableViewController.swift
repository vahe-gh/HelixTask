//
//  NewsTableViewController.swift
//  HelixTaskMac
//
//  Created by Vahe Hakobyan on 10/15/20.
//  Copyright © 2020 Self. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

    // MARK: - Properties
    
    private var newsViewModel: NewsViewModel!
    private let showDetailSegueIdentifier = "ShowDetailSegue"
    
    // MARK: - Initializing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        splitViewController?.delegate = self
        
        refreshControl = UIRefreshControl()
        
        setupTableView()
        newsViewModel = NewsViewModel()
        refreshData()

        if UIDevice.current.userInterfaceIdiom == .pad {
            tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
        }
        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Setup UI
    
    private func setupTableView() {
        
        // Setup UITableViewCell
        let nib = UINib(nibName: ViewCellIdentifiers.news, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ViewCellIdentifiers.news)
        
        /*
        // Setup refresh animation
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("Fetching news", comment: "News"))
        
        if #available(iOS 10.0, *) {
            newsTableView.refreshControl = refreshControl
        } else {
            newsTableView.addSubview(refreshControl)
        }
         */
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
    }
    
    // MARK: - Private methods
    
    @objc private func refreshData() {
        refreshControl?.beginRefreshing()
        newsViewModel.fetchData { [weak self] (response, error) in
//            print("Data has been fetched \(response)")
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl?.endRefreshing()
                
                // Remove unnecessary rows from table footer
                self?.tableView.tableFooterView = UIView(frame: CGRect.zero)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsViewModel.data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewCellIdentifiers.news) as! NewsTableViewCell
        let rowData = newsViewModel.data[indexPath.row]
        cell.viewModel = rowData
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == showDetailSegueIdentifier, let destinationVC = segue.destination as? NewsDetailViewController {
            if let cell = sender as? NewsTableViewCell, let indexPath = tableView.indexPath(for: cell) {
                destinationVC.newsDetailViewModel = newsViewModel.data[indexPath.row]
            }
        }
    }
     
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let splitVC = self.splitViewController else {
            return
        }
                
        guard let navigationVC = splitVC.viewControllers.last as? UINavigationController else {
            return
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        cell.backgroundColor = Theme.Colors.visitedCellBackgroundColor
        
        // Cannot show detail view on iPhone in portrait mode, so I have used segue
        // UISplitViewControllerDelegate delegate does not work
        if let detailVC = navigationVC.viewControllers.first as? NewsDetailViewController {
            detailVC.newsDetailViewModel = newsViewModel.data[indexPath.row]
        } else {
            performSegue(withIdentifier: showDetailSegueIdentifier, sender: cell)
        }
        
        newsViewModel.setAsVisited(index: indexPath.row)
    }
     
}

//extension NewsTableViewController: UISplitViewControllerDelegate {
//
//    // Assuming you want that only on the first launch, but not always; for example in the case that the Master View shows an empty data set; then the solution is just as the Master-Detail template shows:
//    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
//        return true
//        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
//        guard let topAsDetailController = secondaryAsNavController.topViewController as? NewsDetailViewController else { return false }
//        if topAsDetailController.newsDetail == nil {
//            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
//            return true
//        }
//        return false
//    }
//}
