//
//  MovieDetailsVC.swift
//  MyMovieApp
//
//  Created by Ali Osman DURMAZ on 12.04.2022.
//

import UIKit
import Kingfisher

class MovieDetailsVC: UIViewController {

    @IBOutlet weak var movieDetailsSummaryLabel: UILabel!
    @IBOutlet weak var movieDetailsTypleLabel: UILabel!
    @IBOutlet weak var movieDetailsCategoryLabel: UILabel!
    @IBOutlet weak var movieDetailsPriceLabel: UILabel!
    @IBOutlet weak var movieDetailsTitleLabel: UILabel!
    @IBOutlet weak var movieDetailsImage: UIImageView!
    
    var movies: Movies?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movies {
            
            movieDetailsTitleLabel.text = movie.trackName
            movieDetailsCategoryLabel.text = movie.kind
            movieDetailsTypleLabel.text = movie.primaryGenreName
            movieDetailsSummaryLabel.text = movie.longDescription
            let url = URL(string: movie.artworkUrl100!)
            movieDetailsImage.kf.setImage(with: url)
            
            if let price = movie.trackPrice {
                movieDetailsPriceLabel.text = "\(price) TL"
            }
            
            
            
        }
        

    }
    
}
