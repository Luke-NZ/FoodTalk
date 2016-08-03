//
//  FoodTalkTests.swift
//  FoodTalkTests
//
//  Created by 李远 on 25/07/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import XCTest
@testable import FoodTalk


class FoodTalkTests: XCTestCase {
    
    var vc : RestaurantTableViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyborad = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        
        vc = storyborad.instantiateViewControllerWithIdentifier("restaurantsTableView") as! RestaurantTableViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearchFilter() {
        
        vc.viewDidLoad()
        vc.searchFilter("Peace")
        
        print ("Number of Search Result",vc.sr.count,"Number of Restaurants",vc.restaurants.count)
        
        XCTAssert(vc.sr.count == 1, "Search Filter Test Passed")
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
