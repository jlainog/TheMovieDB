//
//  TheMovieDBResponse.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 1/26/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import Foundation

protocol Parseable {
    init(json: NSDictionary)
}

enum TheMovieDBResponse<Value: Parseable> {
    case failure(ErrorData)
    case notConnectedToInternet
    case success(Value)
}
