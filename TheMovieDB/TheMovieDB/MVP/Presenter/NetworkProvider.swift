//
//  GetData.swift
//  TheMovieDB
//
//  Created by Mariana Andrea Orman Berch on 21/9/21.
//

import Foundation

class NetworkProvider {
    
    var movies: [Movie] = []

    var jsonParser = JsonParser()
    
    public func getMovies (completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=1f4d7de5836b788bdfd897c3e0d0a24b&language=en-US&page=1") else {
            completion([])
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }
            self.movies = self.jsonParser.parse(jsonData: data)
            completion(self.movies)
        }
        task.resume()
    }
}
