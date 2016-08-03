//
//  ReviewViewController.swift
//  FoodTalk
//
//  Created by 李远 on 10/07/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    var rating:String?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBAction func ratingBtnTapped(sender: UIButton) {
        
        switch sender.tag {
        case 100:
            rating = "dislike"
        case 200:
            rating = "good"
        case 300:
            rating = "great"
        default:break
        }
        
        performSegueWithIdentifier("unwindToDetailView", sender: sender)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.     
        
        let blurEffect = UIBlurEffect(style: .Dark)
        
        let effectView = UIVisualEffectView(effect: blurEffect)
        
        effectView.frame = view.frame
        
        imageView.addSubview(effectView)

        let scale = CGAffineTransformMakeScale(0, 0)
        let translate = CGAffineTransformMakeTranslation(0, 500)
        
        stackView.transform = CGAffineTransformConcat(scale, translate)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(2) {
            self.stackView.transform = CGAffineTransformIdentity
        }
        
//        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: { 
//            self.stackView.transform = CGAffineTransformIdentity
//            }, completion: nil)

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
