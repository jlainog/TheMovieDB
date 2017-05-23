//
//  MovieWatchListTest.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 2/24/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import XCTest
@testable import TheMovieDB

struct MockMovieData : MovieData {
    let adult: NSNumber = 1
    let backdropPath: String = ""
    let budget: NSNumber = 1
    let homepage: String = ""
    let imdbID: String = ""
    let movieID: NSNumber = 1
    let originalLanguage: String = ""
    let originalTitle: String = ""
    let overview: String = ""
    let popularity: NSNumber = 1
    let posterPath: String = ""
    let releaseDate: String = ""
    let revenue: NSNumber = 1
    let runtime: NSNumber = 1
    let status: String = ""
    let tagline: String = ""
    let title: String = "MockTitle"
    let video: NSNumber = 1
    let voteAverage: NSNumber = 1
    let voteCount: NSNumber = 1
    
    init(json: NSDictionary) {
    }
    init() {
    }
}

class MovieWatchListTest: XCTestCase {
    func testMovieWatchList() {
        let watchList : MovieWatchList = MovieWatchListFacade()
        let movieData : MovieData = MockMovieData()
        
        watchList.add(movie: movieData)
        
        guard let mockData = watchList.list().first else {
            XCTFail()
            return
        }
        
        XCTAssert(mockData.title == movieData.title)
    }
    
    func testMovieWatchListRemove() {
        let watchList : MovieWatchList = MovieWatchListFacade()
        let movieData : MovieData = MockMovieData()
        
        watchList.add(movie: movieData)
        watchList.remove(movie: movieData)

        for obj in watchList.list() {
           XCTAssert(obj.title != movieData.title)
        }
    }
    
    func testRemoveAll() {
        let watchList : MovieWatchList = MovieWatchListFacade()
        let movieData : MovieData = MockMovieData()
        
        watchList.add(movie: movieData)
        watchList.removeAll()
        XCTAssert(watchList.list().count == 0)
    }
}
