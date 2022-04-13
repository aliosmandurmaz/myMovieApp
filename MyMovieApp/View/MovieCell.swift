//
//  MovieCell.swift
//  MyMovieApp
//
//  Created by Ali Osman DURMAZ on 11.04.2022.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieTypeLabel: UILabel!
    @IBOutlet weak var movieCategoryLabel: UILabel!
    @IBOutlet weak var moviePriceLabel: UILabel!
    @IBOutlet weak var movieSummaryLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
