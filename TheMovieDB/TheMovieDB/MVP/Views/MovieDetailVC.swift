//
//  MovieDetailVC.swift
//  TheMovieDB
//
//  Created by Mariana Andrea Orman Berch on 22/9/21.
//

import Foundation
import UIKit

class MovieDetailVC: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var titleMovie: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var overview: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    
    
    var homeScreenVC = HomeScreenVC()
    
    func setValues () {

        releaseDate.text = "Release Date: \(String(describing: homeScreenVC.selectedMovie?.releaseDate))"
        
        titleMovie.text = homeScreenVC.selectedMovie?.releaseDate
        
        overview.text = homeScreenVC.selectedMovie?.overview
        
        rating.text = "Rating: \(String(describing: homeScreenVC.selectedMovie?.rating))"
            
    }
    
    
}
