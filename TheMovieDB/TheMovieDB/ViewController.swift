//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 1/24/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController {

    @IBOutlet var movieListView : MovieListCollectionView!
    var movies : [MovieData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieListView.listDelegate = self
        MoviesFacade.retrieveMovieList(type: .topRated) {
            switch $0 {
            case .success(let response):
                self.movies = response.results
                self.movieListView.reloadData()
            default:
                break
            }
        }
    }
}

// MARK: MovieListViewDelegate
extension ViewController: MovieListViewDelegate {
    func numberOfCells() -> Int {
        return movies?.count ?? 0
    }
    
    func configure(cell: MovieListCell, atIndex index: Int) {
        let movie = movies![index]
        
        cell.titleLabel.text = movie.title
        cell.movieImageView.af_setImage(withURL: URL(string: movie.posterPath)!)
        //cell.rateLabel.text = String(format: "%.1f", movie.voteAverage.floatValue)
        //cell.yearLabel.text = movie.releaseDate
    }
    
    func didSelectRow(atIndex index: Int) {
        
    }
}
