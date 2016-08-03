//
//  RestaurantDetailViewController.swift
//  FoodTalk
//
//  Created by 李远 on 1/07/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    var restaurant: Restaurant!
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        restaurantImageView.image = UIImage(data: restaurant.image!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
