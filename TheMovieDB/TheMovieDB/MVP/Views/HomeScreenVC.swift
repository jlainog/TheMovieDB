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
        
        searchBar.searchTextField.textColor = UIColor.green
        searchBar.searchTextField.backgroundColor = UIColor.black
        searchBar.searchTextField.leftView?.tintColor = UIColor.green
        searchBar.subviews[0].tintColor = UIColor.green
        
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
        
        
        func setImage(from url: String) {
            guard let imageURL = URL(string: url) else { return }

                // So we don't cause a deadlock in the UI:
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: imageURL) else { return }

                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    cell.imageCell.image = image
                }
            }
        }
        
        setImage (from: "https://image.tmdb.org/t/p/w500\(movie.imagePath!)")

        cell.movieName.text = movie.title
        cell.language.text = "Language: \(movie.originalLanguage?.uppercased() ?? "")"
        cell.rating.text = "Rating: \(movie.rating ?? 0)"
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
