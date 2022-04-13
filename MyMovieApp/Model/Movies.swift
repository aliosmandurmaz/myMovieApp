//
//  Movies.swift
//  MyMovieApp
//
//  Created by Ali Osman DURMAZ on 11.04.2022.
//

import Foundation

struct Result: Codable {
    var resultCount: Int
    var results: [Movies]
}


struct Movies: Codable {
    
    var trackName: String?
    var trackPrice: Double?
    var artworkUrl100: String?
    var longDescription: String?
    var kind: String?
    var primaryGenreName: String?
}
