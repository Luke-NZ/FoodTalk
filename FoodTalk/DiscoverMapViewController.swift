//
//  DiscoverMapViewController.swift
//  FoodTalk
//
//  Created by 李远 on 4/08/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit
import MapKit

class DiscoverMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var restaurant = AVObject(className: "Restaurant")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(restaurant["location"] as! String) { (placemarks, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant["name"] as? String
                annotation.subtitle = (self.restaurant["type"] as! String)
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
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
