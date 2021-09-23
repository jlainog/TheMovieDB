//
//  GetData.swift
//  TheMovieDB
//
//  Created by Mariana Andrea Orman Berch on 21/9/21.
//

import Foundation

class GetMovieData {
    
    var movies: [Movie] = []

    var jsonParser = JsonParser()
    
    public func getMovies (completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/list/2?api_key=1f4d7de5836b788bdfd897c3e0d0a24b&language=en-US") else {
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
    
    func filter(searchInput: String) -> [Movie] {
        
        if searchInput == "" {
            return movies
        }
        
        var movies: [Movie] = []
        
        for movie in movies {
            
            let unwrappedTitle = movie.title ?? ""
            
            let unwrappedOriginalTitle = movie.originalLanguage ?? ""
            
            if unwrappedTitle.lowercased().contains(searchInput.lowercased()) || unwrappedOriginalTitle.lowercased().contains(searchInput.lowercased()){
                movies.append(movie)
            }
        }
        return movies
    }
}


//if let unwrappedTitle = movie.title {
//    if unwrappedTitle.lowercased().contains(searchInput.lowercased()) {
//        movies.append(movie)
//    }
//}
//
//if let unwrappedOriginalLanguage = movie.originalLanguage {
//    if unwrappedOriginalLanguage.lowercased().contains(searchInput.lowercased()){
//        movies.append(movie)
//    }
//}
