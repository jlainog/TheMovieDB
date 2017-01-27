//
//  MovieData.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 1/25/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

protocol MovieData {
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
}
