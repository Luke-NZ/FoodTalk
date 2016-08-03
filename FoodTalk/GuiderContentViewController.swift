//
//  GuiderContentViewController.swift
//  FoodTalk
//
//  Created by 李远 on 21/07/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit

class GuiderContentViewController: UIViewController {

    @IBOutlet weak var labelHeading: UILabel!
    @IBOutlet weak var labelFooter: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageCtrl: UIPageControl!
    @IBOutlet weak var doneBtn: UIButton!
    @IBAction func doneBtnTapped(sender: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "GuiderShowed")
    }
    
    var index = 0
    var heading = ""
    var footer = ""
    var imageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        labelHeading.text = heading
        labelFooter.text = footer
        imageView.image = UIImage(named: imageName)
        
        pageCtrl.currentPage = index
        
        if index == 2 {
            
            doneBtn.hidden = false
            doneBtn.setTitle("Try Now", forState: .Normal)
        
        } else {
            doneBtn.hidden = true
        }
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
