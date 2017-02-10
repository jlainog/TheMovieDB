//
//  MovieListCollectionCell.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 2/9/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class MovieListCollectionCell: UICollectionViewCell, MovieListCell {
    @IBOutlet var movieImageView : UIImageView!
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var yearLabel : UILabel!
    @IBOutlet var rateLabel : UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
    }
}
