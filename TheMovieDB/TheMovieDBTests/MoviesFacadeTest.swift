//
//  MoviesFacadeTest.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 1/26/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import TheMovieDB

class MoviesFacadeTest: XCTestCase {
    func testNotInternetConnection() {
        stub(condition: isHost("api.themoviedb.org")) { _ in
            return OHHTTPStubsResponse(error: NSError(domain: NSURLErrorDomain,
                                                      code: NSURLErrorNotConnectedToInternet,
                                                      userInfo: nil))
        }
        let waitingForService = expectation(description: "The movie db / movies call")
        
        MoviesFacade.retrieveMovieList(type: .nowPlaying) { (response) in
            if case .notConnectedToInternet = response {
                print("#### Correct: Not Connected to Internet ####")
            } else {
                XCTFail("### Fail: Not Connected to Internet ###")
            }
            waitingForService.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFailureResponse() {
        stub(condition: isHost("api.themoviedb.org")) { _ in
            return OHHTTPStubsResponse(jsonObject: ["status_message": "Failure Test Message.",
                                                      "status_code": -1220],
                                       statusCode: 401,
                                       headers: nil)
        }
        let waitingForService = expectation(description: "The movie db / movies call")
        
        MoviesFacade.retrieveMovieList(type: .nowPlaying) {
            switch $0 {
            case .failure(let error):
                print("#### Correct: \(error.message) code: \(error.statusCode) ####")
            default:
                XCTFail("### Fail: Not Failure Response ###")
            }
            waitingForService.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSuccessResponse() {
        let mockPage = 1
        let mockResults = [MovieData]()
        let mockTotalResults = 20
        let mockTotalPages = 2
        
        stub(condition: isHost("api.themoviedb.org")) { _ in
            let mockMovieResponse: [String : Any] = [
                "page" : mockPage,
                "results" : mockResults,
                "total_results" : mockTotalResults,
                "total_pages" : mockTotalPages
            ]
            return OHHTTPStubsResponse(jsonObject: mockMovieResponse,
                                       statusCode: 200,
                                       headers: nil)
        }
        
        let waitingForService = expectation(description: "The movie db / movies call")
        
         MoviesFacade.retrieveMovieList(type: .nowPlaying) {
            switch $0 {
            case .success(let movieResponse):
                XCTAssertEqual(movieResponse.page, mockPage)
                //XCTAssertEqual(movieResponse.results, mockResults)
                XCTAssertEqual(movieResponse.totalPages, mockTotalPages)
                XCTAssertEqual(movieResponse.totalResults, mockTotalResults)
            default:
                XCTFail("Could not parse correctly. Debug!!")
            }
            waitingForService.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
