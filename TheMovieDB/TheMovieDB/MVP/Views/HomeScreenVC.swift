//
//  HomeScreenVC.swift
//  TheMovieDB
//
//  Created by Mariana Andrea Orman Berch on 21/9/21.
//

import Foundation
import UIKit

class HomeScreenVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var getMovieData: GetMovieData = GetMovieData()
    
    var movies: [Movie] = GetMovieData().movies
    
    var selectedMovie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMovieData.getMovies(completion: { [weak self] result in self?.movies = result
            
            DispatchQueue.main.async { [weak self] in self?.tableView.reloadData()
            }
        })
    }
}

extension HomeScreenVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell
        else {
            return UITableViewCell()
        }
        //IMG
        cell.movieName.text = movie.title
        cell.language.text = "Language: \(String(describing: movie.originalLanguage))"
        cell.rating.text = "Rating: \(String(describing: movie.rating))"
        return cell
    }
}

extension HomeScreenVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovie = movies[indexPath.row]
        performSegue(withIdentifier: "goToMovieDetailVC", sender: selectedMovie)
    }
}

extension HomeScreenVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movies = getMovieData.filter(searchInput: searchText)
        tableView.reloadData()
    }
}
