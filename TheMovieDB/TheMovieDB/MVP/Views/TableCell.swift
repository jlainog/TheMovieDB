//
//  MovieCell.swift
//  TheMovieDB
//
//  Created by Mariana Andrea Orman Berch on 21/9/21.
//

import Foundation
import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    
    @IBOutlet weak var language: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    
    var movies: [Movie] = NetworkProvider().movies
    
    func setImage(from url: String, cell: TableCell) {
        
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
    
//en la capa de network tienes que tener la funcion que descarga la imagen, esa funcion tienes que pasarle como parametro el path de la imagen y tambien un completion block para que ahi regreses la imagen
//y en la clase de la celda cuando llames a esa funcion para descargarla tienes que ponersela ya a la imageView en el completion
        

    func setMovieCell (movie: Movie, cell: TableCell) {
    
        setImage (from: "https://image.tmdb.org/t/p/w500\(movie.imagePath ?? "")", cell: cell)
                
        cell.movieName.text = movie.title
        cell.language.text = "Language: \(movie.originalLanguage?.uppercased() ?? "")"
        cell.rating.text = "Rating: \(movie.rating ?? 0)"
    }
}
