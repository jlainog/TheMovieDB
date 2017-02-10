//
//  MovieData.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 1/25/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

protocol MovieData : Parseable {
    var adult: NSNumber { get }
    var backdropPath: String { get }
    var budget: NSNumber { get }
    var homepage: String { get }
    var imdbID: String { get }
    var movieID: NSNumber { get }
    var originalLanguage: String { get }
    var originalTitle: String { get }
    var overview: String { get }
    var popularity: NSNumber { get }
    var posterPath: String { get }
    var releaseDate: String { get }
    var revenue: NSNumber { get }
    var runtime: NSNumber { get }
    var status: String { get }
    var tagline: String { get }
    var title: String { get }
    var video: NSNumber { get }
    var voteAverage: NSNumber { get }
    var voteCount: NSNumber { get }
}

struct Movie: MovieData {
    let adult: NSNumber
    let backdropPath: String
    let budget: NSNumber
    let homepage: String
    let imdbID: String
    let movieID: NSNumber
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: NSNumber
    let posterPath: String
    let releaseDate: String
    let revenue: NSNumber
    let runtime: NSNumber
    let status: String
    let tagline: String
    let title: String
    let video: NSNumber
    let voteAverage: NSNumber
    let voteCount: NSNumber
    
    init(json: NSDictionary) {
        self.adult = json["adult"] as? NSNumber ?? NSNumber(value: 0)
        self.backdropPath = TheMovieDBService.imgBaseURL + (json["backdrop_path"] as? String ?? "")
        self.budget = json["budget"] as? NSNumber ?? NSNumber(value: 0)
        self.homepage = json["homepage"] as? String ?? ""
        self.imdbID = json["imdb_id"] as? String ?? ""
        self.movieID = json["id"] as? NSNumber ?? NSNumber(value: 0)
        self.originalLanguage = json["original_language"] as? String ?? ""
        self.originalTitle = json["original_title"] as? String ?? ""
        self.overview = json["overview"] as? String ?? ""
        self.popularity = json["popularity"] as? NSNumber ?? NSNumber(value: 0)
        self.posterPath = TheMovieDBService.imgBaseURL + (json["poster_path"] as? String ?? "")
        self.releaseDate = json["release_date"] as? String ?? ""
        self.revenue = json["revenue"] as? NSNumber ?? NSNumber(value: 0)
        self.runtime = json["runtime"] as? NSNumber ?? NSNumber(value: 0)
        self.status = json["status"] as? String ?? ""
        self.tagline = json["tagline"] as? String ?? ""
        self.title = json["title"] as? String ?? ""
        self.video = json["video"] as? NSNumber ?? NSNumber(value: 0)
        self.voteAverage = json["vote_average"] as? NSNumber ?? NSNumber(value: 0)
        self.voteCount = json["vote_count"] as? NSNumber ?? NSNumber(value: 0)
    }
    
}
