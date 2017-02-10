//
//  MovieListViewTest.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 2/9/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import XCTest
import UIKit
@testable import TheMovieDB

struct MockInfo {
    let title : String
    let rate : String
    let year : String
}

class MockListViewDelegate: MovieListViewDelegate {
    var mockInfos = [MockInfo]()
    
    func numberOfCells() -> Int {
        return mockInfos.count
    }
    func configure(cell: MovieListCell, atIndex index: Int) {
        let mock = mockInfos[index]
        cell.titleLabel.text = mock.title
        //cell.rateLabel.text = mock.rate
        //cell.yearLabel.text = mock.year
    }
    func didSelectRow(atIndex index: Int) {
    }
}

class MovieListViewTest: XCTestCase {
    
    var listViewsToTest: [MovieListView] = []
    let listDelegate = MockListViewDelegate()
    
    override func setUp() {
        super.setUp()
        let frame = CGRect(x: 0, y: 0, width: 500, height: 1000)
        let tableView = MovieListTableView(frame: frame)
        let collectionView = MovieListCollectionView(frame: frame)

        add(movieListView: tableView)
        add(movieListView: collectionView)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testConfigureCell() {
        var index = 0
        let mockInfo = MockInfo(title: "Mock Title",
                                rate: "Mock rate",
                                year: "Mock Year")
        
        listDelegate.mockInfos.append(mockInfo)
        index = listDelegate.mockInfos.count - 1
        listViewsToTest.forEach { (movieListView) in
            movieListView.reloadData()
            
            //WORKAROUND: collectionViews don't have visible cell
            if let collectionView = movieListView as? MovieListCollectionView {
                if collectionView.visibleCells.count == 0 {
                    let cell = collectionView.collectionView(collectionView, cellForItemAt: IndexPath(item: index, section: 0)) as? MovieListCell
                    
                    XCTAssertTrue(cell?.titleLabel.text == mockInfo.title)
                    return
                }
            }
            
            let cell = movieListView.cell(atIndex: index)
            
            XCTAssertTrue(cell?.titleLabel.text == mockInfo.title)
           // XCTAssertTrue(cell?.rateLabel.text == mockInfo.rate)
           // XCTAssertTrue(cell?.yearLabel.text == mockInfo.year)
        }
    }
    
    private func add(movieListView: MovieListView) {
        movieListView.listDelegate = listDelegate
        movieListView.reloadData()
        listViewsToTest.append(movieListView)
    }
}
