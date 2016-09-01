//
//  DiscoverDetailTableViewController.swift
//  FoodTalk
//
//  Created by 李远 on 4/08/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit

class DiscoverDetailTableViewController: UITableViewController {

    var restaurant = AVObject(className: "Restaurant")

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let img = restaurant["image"] as? AVFile {
            imageView?.image = UIImage(data: img.getData())
        }

        tableView.estimatedRowHeight = 36
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.tableFooterView = UIView(frame: CGRectZero)

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
        return 3
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("discoverDetailCell", forIndexPath: indexPath) as! DiscoverDetailTableViewCell

        // Configure the cell...

        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant["name"] as? String
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant["type"] as? String
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant["location"] as? String
            
//        case 3:
//            cell.fieldLabel.text = "来过与否"
//            cell.valueLabel.text = restaurant["isVisited"] as？Boolean ? "来过了" : "没来过"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
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
        
        if segue.identifier == "discoverShowMap" {
            let destVC = segue.destinationViewController as! DiscoverMapViewController
            destVC.restaurant = self.restaurant
        }

    }


}
