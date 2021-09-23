//
//  JsonParser.swift
//  TheMovieDB
//
//  Created by Mariana Andrea Orman Berch on 21/9/21.
//

import Foundation

class JsonParser {
    
  //let friends = try response.nestedContainer(keyedBy: CodingKeys.self, forKey: .friends)
    
    func parse(jsonData: Data) -> [Movie] {
        
        let result = (try? JSONDecoder().decode(MoviesGroup.self, from: jsonData))

        return result!.movies
    }
}
