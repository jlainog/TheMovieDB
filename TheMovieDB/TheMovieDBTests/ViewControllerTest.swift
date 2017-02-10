//
//  ViewControllerTest.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 2/9/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import XCTest
import UIKit
@testable import TheMovieDB

class ViewControllerTest: XCTestCase {
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let identifier = String(describing: ViewController.self)
        
        viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! ViewController
        _ = viewController.view
    }
    
    func testMovieListViewDidLoad() {
        XCTAssertTrue(viewController.movieListView != nil, "The view should be set")
    }
    
    func testSetMovieListDelegate() {
        XCTAssertTrue(viewController.movieListView.listDelegate != nil, "The list delegate should be set")
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

}
