//
//  Restaurant+CoreDataProperties.swift
//  FoodTalk
//
//  Created by 李远 on 19/07/16.
//  Copyright © 2016 Luke. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Restaurant {

    @NSManaged var image: NSData?
    @NSManaged var isVisited: NSNumber
    @NSManaged var location: String
    @NSManaged var name: String
    @NSManaged var rating: String?
    @NSManaged var type: String

}
