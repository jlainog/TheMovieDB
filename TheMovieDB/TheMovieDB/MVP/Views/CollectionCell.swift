//
//  CollectionCell.swift
//  TheMovieDB
//
//  Created by Mariana Andrea Orman Berch on 28/9/21.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    static let identifier = "collectionCell"
    
    var imageCell: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "house")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    var movieName: UILabel = {
        let name = UILabel()
        name.text = "name"
        return name
    }()
    
    var language: UILabel = {
        let language = UILabel()
        language.text = "language"
        return language
    }()
    
    var rating: UILabel = {
        let rating = UILabel()
        rating.text = "rating"
        return rating
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        contentView.addSubview(imageCell)
        contentView.addSubview(movieName)
        contentView.addSubview(language)
        contentView.addSubview(rating)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageCell.frame = CGRect(x: 0, y: contentView.frame.size.height-50, width: contentView.frame.size.width, height: 50)
        
        movieName.frame = CGRect(x: 5, y: contentView.frame.size.height-60, width: contentView.frame.size.width-5, height: 10)
        
        language.frame = CGRect(x: 5, y: contentView.frame.size.height-70, width: contentView.frame.size.width-5, height: 10)
        
        rating.frame = CGRect(x: 5, y: contentView.frame.size.height-80, width: contentView.frame.size.width-5, height: 10)
        
    }
    
    var movies: [Movie] = NetworkProvider().movies
    
    func setImage(from url: String, cell: CollectionCell) {
        
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
        

    func setMovieCell (movie: Movie, cell: CollectionCell) {
    
        setImage (from: "https://image.tmdb.org/t/p/w500\(movie.imagePath ?? "")", cell: cell)
                
        cell.movieName.text = movie.title
        cell.language.text = "Language: \(movie.originalLanguage?.uppercased() ?? "")"
        cell.rating.text = "Rating: \(movie.rating ?? 0)"
    }
}

