//
//  MoviesResponseData.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 1/26/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

protocol MovieResponseData : Parseable {
    var page : Int { get }
    var results : [MovieData] { get }
    var totalResults : Int { get }
    var totalPages : Int { get }
}

struct MovieResponse : MovieResponseData {
    let page : Int
    let results : [MovieData]
    let totalResults : Int
    let totalPages : Int
    
    init(json: NSDictionary) {
        self.page = json["page"] as? Int ?? 0
        self.totalResults = json["total_results"] as? Int ?? 0
        self.totalPages = json["total_pages"] as? Int ?? 0
        
        guard let moviesJson = json["results"] as? [NSDictionary] else {
            self.results = []
            return
        }
        
        self.results = moviesJson.enumerated().map { offset, element in Movie(json: element) }
    }
    
    init(page: Int,
         results: [MovieData],
         totalResults: Int,
         totalPages: Int) {
        self.page = page
        self.results = results
        self.totalResults = totalResults
        self.totalPages = totalPages
    }
}
