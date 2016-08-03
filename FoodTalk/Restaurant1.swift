//
//  Restaurant.swift
//  FoodTalk
//
//  Created by 李远 on 2/07/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import Foundation

struct Restaurant1 {
    
    var name:String
    var type:String
    var location:String
    var image:String
    var isVisited:Bool
    var rating = ""
    
    init(name: String, type: String, location: String, image: String, isVisited: Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isVisited = isVisited
    }
    
}

// let r1 = Restaurant(name: <#T##String#>, type: <#T##String#>, location: <#T##String#>, image: <#T##String#>, isVisited: <#T##Bool#>)