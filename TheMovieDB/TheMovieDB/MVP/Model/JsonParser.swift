//
//  JsonParser.swift
//  TheMovieDB
//
//  Created by Mariana Andrea Orman Berch on 21/9/21.
//

import Foundation

class JsonParser {
        
    func parse(jsonData: Data) -> [Movie] {
        
        let result = (try? JSONDecoder().decode(MoviesGroup.self, from: jsonData))

        return result?.movies ?? []
    }
}
