//
//  GuiderPageViewController.swift
//  FoodTalk
//
//  Created by 李远 on 21/07/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit

class GuiderPageViewController: UIPageViewController,UIPageViewControllerDataSource {
    
    var headings = ["Customization","Restaurant Location","Find Restaurant"]
    var images = ["foodpin-intro-1","foodpin-intro-2","foodpin-intro-3"]
    var footers = ["Add your favorite restaurant anytime","Locate your target restaurant","Find recommendation from others"]
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! GuiderContentViewController).index
        
        index += 1
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! GuiderContentViewController).index
        
        index -= 1
        
        return viewControllerAtIndex(index)
        
    }
    
    func viewControllerAtIndex(index: Int) -> GuiderContentViewController? {
        
        if case 0 ..< headings.count = index {
            
            //创建一个新 ViewController 并传递数据
            
            if let contentVC = storyboard?.instantiateViewControllerWithIdentifier("GuiderContentController") as? GuiderContentViewController {
                
                contentVC.heading = headings[index]
                contentVC.footer = footers[index]
                contentVC.imageName = images[index]
                contentVC.index = index
                
                return contentVC
            }
        } else {
            return nil
        }
        
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        dataSource = self
        
        if let startVC = viewControllerAtIndex(0) {
            
            setViewControllers([startVC], direction: .Forward, animated: true, completion: nil)
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
