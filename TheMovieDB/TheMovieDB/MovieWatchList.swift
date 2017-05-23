//
//  MovieWatchList.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 2/24/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

protocol MovieWatchList {
    func list() -> [MovieData]
    
    func add(movie: MovieData)
    func remove(movie: MovieData)
    
    func removeAll()
}

class MovieWatchListFacade : MovieWatchList {
    var array = [MovieData]()
    
    func list() -> [MovieData] {
        return array
    }
    
    func add(movie: MovieData) {
        array.append(movie)
    }
    
    func remove(movie: MovieData) {
        var idx : Int?
        
        for (index, data) in array.enumerated() {
            if data.title == movie.title {
                idx = index
            }
        }
        
        if let i = idx {
            array.remove(at: i)
        }
    }
    
    func removeAll() {
        array.removeAll()
    }
}
