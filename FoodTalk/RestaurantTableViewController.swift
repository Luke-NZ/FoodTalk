 //
//  RestaurantTableViewController.swift
//  FoodTalk
//
//  Created by 李远 on 25/06/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController,NSFetchedResultsControllerDelegate,UISearchResultsUpdating {

    var restaurants:[Restaurant] = []
    var sr : [Restaurant] = []
    var frc : NSFetchedResultsController!
    var sc : UISearchController!
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if var textToSearch = sc.searchBar.text {
            
            textToSearch = textToSearch.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            searchFilter(textToSearch)
            tableView.reloadData()
        }
    }
    
    func searchFilter(textToSearch: String) {
        
        sr = restaurants.filter({ (r) -> Bool in
            return r.name.containsString(textToSearch)
        })
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        sc = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = sc.searchBar
        sc.searchBar.placeholder = "Search by Restaurant name"
        sc.searchBar.searchBarStyle = .Minimal
//        sc.searchBar.tintColor = UIColor.whiteColor()
//        sc.searchBar.barTintColor = UIColor.orangeColor()
        
        sc.searchResultsUpdater = self
        sc.dimsBackgroundDuringPresentation = false
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let request = NSFetchRequest(entityName: "Restaurant")
        
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let buffer = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
        
        frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: buffer!, sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        
        do {
            try frc.performFetch()
            restaurants = frc.fetchedObjects as! [Restaurant]
        } catch {
            print(error)
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if defaults.boolForKey("GuiderShowed") {
            return
        }
        
        if let guideVC = storyboard?.instantiateViewControllerWithIdentifier("GuideController") as? GuiderPageViewController {
            
            presentViewController(guideVC,animated:true,completion:nil)
        }
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case .Insert:
            if let _newindexPath = newIndexPath{
                tableView.insertRowsAtIndexPaths([_newindexPath], withRowAnimation: .Automatic)
            }
            
        case .Delete:
            if let _indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: .Automatic)
            }
        case .Update:
            if let _indextPath = indexPath {
                tableView.reloadRowsAtIndexPaths([_indextPath], withRowAnimation: .Automatic)
            }
        default:
            tableView.reloadData()
        }
        
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sc.active ? sr.count: restaurants.count
    }
    
    /*
    // 选择了行以后的操作
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let alert = UIAlertController(title: "亲,您选择了我!", message: "消息", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        
        let dialActionProcess = { (action: UIAlertAction) -> Void in
            
            let alert = UIAlertController(title: "提示", message: "您拨打的电话暂时无法接通", preferredStyle: .Alert)
            let action = UIAlertAction(title: "ok", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        let dialAction = UIAlertAction(title: "拨打 09-6532 \(indexPath.row)", style: .Default, handler: dialActionProcess)
        
        let beenHereBefore = UIAlertAction(title: "我来过", style: .Default) { (_) in
            
            self.restaurantVisited[indexPath.row] = true
            tableView.reloadData()
            
//            let cell = tableView.cellForRowAtIndexPath(indexPath)
//            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        alert.addAction(cancelAction)
        alert.addAction(dialAction)
        alert.addAction(beenHereBefore)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    */
    
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomTableViewCell
        
        let r = sc.active ? sr[indexPath.row] : restaurants[indexPath.row]
        
        // Configure the cell...
        
        cell.restaurantImage.image = UIImage(data: r.image!)
        cell.restaurantName.text = r.name
        cell.location.text = r.location
        cell.type.text = r.type
        cell.facImageView.image = UIImage(named: "heart")
        
        cell.restaurantImage.layer.cornerRadius = cell.restaurantImage.frame.size.width / 2
        cell.restaurantImage.clipsToBounds = true
        
        //  显示"Favorite"图标
        if r.isVisited.boolValue {
            cell.facImageView.hidden = false
        } else {
            cell.facImageView.hidden = true
        }

        // Fix Bug "一炮双响"
//        if restaurantVisited[indexPath.row] {
//            cell.accessoryType = .Checkmark
//        } else {
//            cell.accessoryType = .None
//        }
//        cell.accessoryType = restaurantVisited[indexPath.row] ? .Checkmark : .None
        
        return cell
    }
    


    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return !sc.active
    }



    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {

            // Delete the row from the data source
            restaurants.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // Override to support customised row action
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let shareAction = UITableViewRowAction(style: .Default, title: "Share") { (action, indexPath) -> Void in
            
            let alert = UIAlertController(title: "Share to", message: "Social Media", preferredStyle: .ActionSheet)
            
            let facebookAction = UIAlertAction(title: "Facebook", style: .Default, handler: nil)
            let twitterAction = UIAlertAction(title: "Twitter", style: .Default, handler: nil)
            let weChatAction = UIAlertAction(title: "weChat", style: .Default, handler: nil)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
            alert.addAction(facebookAction)
            alert.addAction(twitterAction)
            alert.addAction(weChatAction)
            alert.addAction(cancelAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
//        shareAction.backgroundColor = UIColor.grayColor()
        shareAction.backgroundColor = UIColor(red: 11/255, green: 56/255, blue: 156/255, alpha: 1)
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { (action, indexPath) in
            
            let buffer = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
            let restaurantToDel = self.frc.objectAtIndexPath(indexPath) as! Restaurant
            
            buffer?.deleteObject(restaurantToDel)
            
            do {
                try buffer?.save()
            } catch {
                print(error)
            }
            
        }
        
        return [shareAction,deleteAction   ]
    }

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
        
        if segue.identifier == "showRestaurantDetail" {
            
            let destVC = segue.destinationViewController as! DetailTableViewController
            
            destVC.hidesBottomBarWhenPushed = true
            
            destVC.restaurant = sc.active ? sr[(tableView.indexPathForSelectedRow!.row)] :
                restaurants[(tableView.indexPathForSelectedRow!.row)]
            
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        
    }
}
