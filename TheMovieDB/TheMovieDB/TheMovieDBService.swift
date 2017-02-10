//
//  TheMovieDBService.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 1/26/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Alamofire
import Foundation

struct TheMovieDBService {
    static let host = "https://api.themoviedb.org/3"
    static let imgBaseURL =  "https://image.tmdb.org/t/p/w500"
    static let apiKey = "1f4d7de5836b788bdfd897c3e0d0a24b"
    
    static func handleResponse<T:Parseable>(response: Alamofire.DataResponse<Any>) -> TheMovieDBResponse<T> {
        guard let statusCode = response.response?.statusCode,
            let value = response.result.value as? NSDictionary,
            response.result.isSuccess == true else {
                if let error = response.result.error as? NSError, error.code == NSURLErrorNotConnectedToInternet {
                    return (.notConnectedToInternet)
                }
                return (.failure(Error(statusCode: 0, message: "Something Went Wrong")))
        }
        
        switch statusCode {
        case 200:
            return (TheMovieDBResponse.success(T(json: value)))
        case 401, 404:
            return (TheMovieDBResponse.failure(Error(json: value)))
        default:
            return (TheMovieDBResponse.failure(Error(statusCode: 0, message: "Something Went Wrong")))
        }
    }
}
