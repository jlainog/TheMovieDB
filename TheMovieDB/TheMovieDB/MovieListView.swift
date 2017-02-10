//
//  MovieListView.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 2/8/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

protocol MovieListCell {
    var movieImageView : UIImageView! { get }
    var titleLabel : UILabel! { get }
    var yearLabel : UILabel! { get }
    var rateLabel : UILabel! { get }
}

protocol MovieListView: class {
    weak var listDelegate: MovieListViewDelegate? { get set }
    
    func cell(atIndex: Int) -> MovieListCell?
    func reloadData()
}

protocol MovieListViewDelegate: class {
    func numberOfCells() -> Int
    func configure(cell: MovieListCell, atIndex index: Int)
    func didSelectRow(atIndex index: Int)
}
