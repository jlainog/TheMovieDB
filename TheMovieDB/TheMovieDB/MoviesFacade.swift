//
//  MoviesFacade.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 1/26/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Alamofire
import Foundation

struct MoviesFacade : MovieService {
    static func retrieveMovieList(type: MoviesListType, completion: @escaping MovieResponseHandler) {
        let urlRequest = TheMovieDBService.host + type.path
        
        Alamofire.request(urlRequest,
                          method: .get,
                          parameters: ["api_key": TheMovieDBService.apiKey],
                          encoding: URLEncoding.default,
                          headers: nil)
            .responseJSON {
                response in
                completion(TheMovieDBService.handleResponse(response: response))
        }
    }
}
