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

    @IBOutlet var containerView : UIView!
    var movieListView : MovieListView!
    var movies : [MovieData]?
    var selectedListType : MoviesListType = .nowPlaying
    fileprivate let animatorManager = SwipeTransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMovieListView()
        retreiveMovieList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segue for the popover configuration window
        if segue.identifier == "MoviesCategories" {
            let controller = segue.destination as! MoviesCategoriesViewController
            
            controller.selectedListType = selectedListType
            controller.preferredContentSize = CGSize(width: 150, height: 200)
            controller.onDidChange = {
                type in
                self.selectedListType = type
                self.retreiveMovieList()
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
        let imageURLPath = UIDevice.current.userInterfaceIdiom == .pad ?
            movie.posterPath :
            movie.backdropPath
        
        cell.titleLabel.text = movie.title
        cell.movieImageView.af_setImage(withURL: URL(string: imageURLPath)!)
//        cell.rateLabel.text = String(format: "%.1f", movie.voteAverage.floatValue)
//        cell.yearLabel.text = movie.releaseDate
    }
    
    func didSelectRow(atIndex index: Int) {
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as! MovieDetailViewController
        
        detailController.movieData = movies?[index]
        detailController.transitioningDelegate = animatorManager
        animatorManager.addSwipeInteractiveTransition(toController: detailController)
        present(detailController, animated: true)
    }
}

// MARK: Private Methods
private extension ViewController {
    func retreiveMovieList() {
        MoviesFacade.retrieveMovieList(type: selectedListType) {
            switch $0 {
            case .success(let response):
                self.movies = response.results
                self.movieListView.reloadData()
            default:
                break
            }
        }
    }
    
    func configureMovieListView() {
        let frame = containerView.frame
        let movieListView : MovieListView = UIDevice.current.userInterfaceIdiom == .pad ?
            MovieListCollectionView(frame: frame) :
            MovieListTableView(frame: frame)
        let contentView = movieListView as! UIView
        
        movieListView.listDelegate = self
        self.movieListView = movieListView
        containerView.addSubview(contentView)
        contentView.addConstraints(toFillSuperView: containerView)
        contentView.backgroundColor = UIColor.clear
    }
}
