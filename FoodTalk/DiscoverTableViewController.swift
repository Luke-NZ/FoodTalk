//
//  DiscoverTableViewController.swift
//  FoodTalk
//
//  Created by 李远 on 23/07/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit

class DiscoverTableViewController: UITableViewController, UISearchResultsUpdating {
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    var restaurants: [AVObject] = []
    
    var sc: UISearchController!
    
    var sr: [AVObject] = []
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if var textToSearch = sc.searchBar.text {
            
            textToSearch = textToSearch.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            searchFilter(textToSearch)
            tableView.reloadData()
        }
    }
     
    func searchFilter (textToSearch: String) {
        
        sr = restaurants.filter({ (r) -> Bool in
            return r["name"].containsString(textToSearch)
        })
    }

    func getNewData() {
        getRecordFromCloud(true)
    }
    
    func getRecordFromCloud(needNew: Bool = false) {
        
        let query = AVQuery(className: "Restaurant")
        
        query.addDescendingOrder("createdAt")
        
        if needNew {
            query.cachePolicy = .IgnoreCache
        } else {
            query.cachePolicy = .CacheElseNetwork
            query.maxCacheAge = 60 * 2
        }
        
        if query.hasCachedResult() {
            print("Query result from Cache!")
        }
        
        query.findObjectsInBackgroundWithBlock { (objects, errorMsg) in
            
            guard errorMsg == nil else {
                print(errorMsg.localizedDescription)
                return
            }
            
            if let objects = objects as? [AVObject] {
                self.restaurants = objects
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ 
                    self.tableView.reloadData()
                    self.spinner.stopAnimating()
                    self.refreshControl?.endRefreshing()
                })
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        sc = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = sc.searchBar
        sc.searchResultsUpdater = self
        sc.dimsBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Search by restaurant name"
        
        spinner.hidesWhenStopped = true
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        
        getRecordFromCloud()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.backgroundColor = UIColor.whiteColor()
        self.refreshControl?.tintColor = UIColor.grayColor()
        self.refreshControl?.addTarget(self, action: #selector(DiscoverTableViewController.getNewData), forControlEvents: .ValueChanged)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if sc.active {
            return sr.count
        } else {
            return restaurants.count
        }
        
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DiscoverTableViewCell

        // Configure the cell...
        let restaurant = sc.active ? sr[indexPath.row] : restaurants[indexPath.row]

        cell.restaurantName.text = restaurant["name"] as? String
        cell.restaurantLocation.text = restaurant["location"] as? String
        cell.restaurantType.text = restaurant["type"] as? String
        
        // Local Image Placeholder
        cell.restaurantImage.image = UIImage(named: "photoalbum")
        
        if let img = restaurant["image"] as? AVFile {
            
            img.getDataInBackgroundWithBlock({ (data, errorMsg) in
                
                guard errorMsg == nil else {
                    print(errorMsg.localizedDescription)
                    return
                }
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ 
                    
                    cell.restaurantImage.image = UIImage(data: img.getData())
                    
                    cell.restaurantImage.layer.cornerRadius = cell.restaurantImage.frame.size.width / 3
                    cell.restaurantImage.clipsToBounds = true

                })
            })
        }

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return !sc.active
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "discoverRestaurantDetail" {
            
            let destVC = segue.destinationViewController as! DiscoverDetailTableViewController
            
            destVC.restaurant = sc.active ? sr[(tableView.indexPathForSelectedRow!.row)] : restaurants[(tableView.indexPathForSelectedRow!.row)]
            
        }

    }


}
