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
    
    var networkProvider: NetworkProvider = NetworkProvider()
    
    var filter: Filter = Filter()
    
    var movies: [Movie] = NetworkProvider().movies
    
    var selectedMovie: Movie?
    
    var tableCell: TableCell = TableCell()
    
    var collectionCell: CollectionCell = CollectionCell()
    
    let deviceIdiom = UIDevice.current.userInterfaceIdiom
    
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width/3)-4, height: (view.frame.size.height/3)-4)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        
        searchBar.searchTextField.textColor = UIColor.green
        searchBar.searchTextField.backgroundColor = UIColor.black
        searchBar.searchTextField.leftView?.tintColor = UIColor.green
        searchBar.subviews[0].tintColor = UIColor.green
        
        switch deviceIdiom {
        case .pad:
            tableView.isHidden = true
            collectionView.isHidden = false
        default:
            tableView.isHidden = false
            collectionView.isHidden = true
        }
        
        networkProvider.getMovies(completion: { [weak self] result in self?.movies = result
            
            DispatchQueue.main.async { [weak self] in self?.tableView.reloadData()
            }
        })
    }
}

extension HomeScreenVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = movies[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.identifier, for: indexPath) as? CollectionCell else {
            return UICollectionViewCell()
        }
        
        collectionCell.setMovieCell(movie: movie, cell: cell)
        return cell
    }
}


extension HomeScreenVC: UICollectionViewDelegate {
    
}

/*
 0) LISTO: crear clase collectionviewcell
 1) crear collectionView, ver márgenes, diseñarla un poco,
 2) LISTO: ocultar tableview y mostrar collection view según device, en el viewdidload
 3) LISTO: setear los valores que van en la collectionview según las celdas
 */



extension HomeScreenVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? TableCell
        else {
            return UITableViewCell()
        }
        
        tableCell.setMovieCell(movie: movie, cell: cell)
        
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
        movies = networkProvider.movies
        movies = filter.filter(searchInput: searchText, movies: movies)
        tableView.reloadData()
    }
}


