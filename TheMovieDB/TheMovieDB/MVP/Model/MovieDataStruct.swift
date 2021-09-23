//
//  MovieDataStruct.swift
//  TheMovieDB
//
//  Created by Mariana Andrea Orman Berch on 21/9/21.
//

import Foundation

struct Movie: Decodable {
    //so the names of the keys are more descriptive:
    private enum CodingKeys: String, CodingKey {
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case imagePath = "backdrop_path"
        case rating = "vote_average"
        case title = "title"
    }
    var overview: String?
    var releaseDate: String?
    var originalLanguage: String?
    var title: String?
    var imagePath: String?
    var rating: Double?
}

struct MoviesGroup: Decodable {
    private enum CodingKeys: String, CodingKey {
        case movies = "items"
    }
    var movies: [Movie]
}
