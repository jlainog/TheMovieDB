//
//  Filter.swift
//  TheMovieDB
//
//  Created by Mariana Andrea Orman Berch on 27/9/21.
//

import Foundation

var networkProvider: NetworkProvider = NetworkProvider()

class Filter {
    
    func filter(searchInput: String, movies: [Movie]) -> [Movie] {
        
        if searchInput == "" {
            return movies
        }
        
        var filteredMovies: [Movie] = []
        
        for movie in movies {
            
            if movie.title?.lowercased().contains(searchInput.lowercased()) ?? false || movie.originalLanguage?.lowercased().contains(searchInput.lowercased()) ?? false {
                filteredMovies.append(movie)
            }
        }
        return filteredMovies
    }
}
