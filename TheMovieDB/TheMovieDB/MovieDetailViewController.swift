//
//  MovieDetailViewController.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 2/20/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailViewController: UIViewController {
    @IBOutlet var posterImageView : UIImageView!
    @IBOutlet var backdropImageView : UIImageView!
    @IBOutlet var titleLabel : UILabel!
    
    var movieData : MovieData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posterImageView.af_setImage(withURL: URL(string: movieData.posterPath)!)
        backdropImageView.af_setImage(withURL: URL(string: movieData.backdropPath)!)
        titleLabel.text = movieData.title
    }
    
}

extension MovieDetailViewController : ImageFrameTransitionAnimationProtocol {
    var transitionSourceImageView : UIImageView {
        return UIDevice.current.userInterfaceIdiom == .pad ?
            posterImageView : backdropImageView
    }
}
