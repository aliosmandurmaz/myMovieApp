//
//  ViewController.swift
//  MyMovieApp
//
//  Created by Ali Osman DURMAZ on 10.04.2022.
//

import UIKit
import Kingfisher

class MoviesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var moviesList = [Movies]()
    var isSearching = false
    var searchingWord: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isSearching {
            makingSearch(searchWord: searchingWord!)
        } else {
            getAllMovies()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        if segue.identifier == "toMovieDetails" {
            let moviesDestination = segue.destination as! MovieDetailsVC
            moviesDestination.movies = moviesList[indeks!]
        }
    }
    
    func getAllMovies() {
       
        let url = URL(string: "https://itunes.apple.com/search?media=movie&term=a&limit=200&country=tr&lang=tr_Tr")!;
        
        URLSession.shared.dataTask(with: url) { data,response,error in
            
            if error != nil || data == nil {
                print("Hata");
                return;
            }
            
            do {
                
                let jsonAnswer = try? JSONDecoder().decode(Result.self, from: data!);
                
                if let incomingMovieList = jsonAnswer?.results   {
                    self.moviesList = incomingMovieList;
                }
               
                DispatchQueue.main.async {
                    self.tableView.reloadData();
                }
                
            } catch  {
                print(error.localizedDescription);
            }
        } .resume();
        
    }
    
    func makingSearch(searchWord:String) {
        
        var request = URLRequest(url: URL(string: "https://itunes.apple.com/search?media=movie&term=Spide&limit=200&country=tr&lang=tr_Tr")!);
        
        request.httpMethod = "POST";
        
        let postString = "term=\(searchWord)";
        
        request.httpBody = postString.data(using: .utf8);
        
        URLSession.shared.dataTask(with: request) { data,response,error in
            
            if error != nil || data == nil {
                print("Hata");
                return;
            }
            
            do {
                
                let jsonAnswer = try? JSONDecoder().decode(Result.self, from: data!);
                
                if let incomigMovieList = jsonAnswer?.results {
                    self.moviesList = incomigMovieList;
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData();
                }
                
            } catch {
                print(error.localizedDescription);
            }
        } .resume();
    }




}

extension MoviesVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = self.moviesList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieCell
        cell.movieTitleLabel.text = movie.trackName
        cell.movieCategoryLabel.text = movie.kind
        cell.movieTypeLabel.text = movie.primaryGenreName
        if let price = movie.trackPrice {
            cell.moviePriceLabel.text = "\(price) TL"
        }
        
        cell.movieSummaryLabel.text = movie.longDescription
        let url = URL(string: movie.artworkUrl100!)
        cell.movieImage.kf.setImage(with: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toMovieDetails", sender: indexPath.row)
    }
    
}

extension MoviesVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        searchingWord = searchText
        
        if searchingWord == "" {
            isSearching = false;
            getAllMovies()
        }else {
            isSearching = true;
        }
        
        makingSearch(searchWord: searchingWord!)
    }
}
