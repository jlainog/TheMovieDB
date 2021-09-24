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
    
    func filter(searchInput: String) -> [Movie] {//should be in the model
        
        if searchInput == "" {
            return movies
        }
        
        var filteredMovies: [Movie] = []
        
        for movie in movies {
            
            if movie.title!.lowercased().contains(searchInput.lowercased()) || movie.originalLanguage!.lowercased().contains(searchInput.lowercased()){
                filteredMovies.append(movie)
            }
        }
        return filteredMovies
    }
}


//let unwrappedTitle = movie.title ?? ""
//
//let unwrappedOriginalTitle = movie.originalLanguage ?? ""

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
