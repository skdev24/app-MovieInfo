//
//  MoviesVC.swift
//  MovieInfo
//
//  Created by Shivam Dev on 15/05/18.
//  Copyright © 2018 Shivam Dev. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var viewConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var aboutBtn: UIButton!
    @IBOutlet weak var favBtn: UIButton!
    
    
    
    
    let APIKEY = "2084636"
    var search = [String]()
    var searchID = [String]()
    var searchImage = [String]()
    var track = 0
    var movieDetails: MovieDetails!
    var newImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blurView.layer.cornerRadius = 15
        sideView.layer.shadowColor = #colorLiteral(red: 0.3858584166, green: 0.5081222653, blue: 0.973092854, alpha: 0.2318065068)
        sideView.layer.shadowOpacity = 1
        sideView.layer.shadowOffset = CGSize(width: 5, height: 0)
        viewConstraint.constant = -165
        
        aboutBtn.isHidden = true
        favBtn.isHidden = true
        
        searchBar.delegate = self
        
        
    }
    
    @IBAction func showSideView(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.viewConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    
    @IBAction func panPerform(_ sender: UIPanGestureRecognizer) {
        searchBar.resignFirstResponder()
        if sender.state == .began || sender.state == .changed {
            
            let translation = sender.translation(in: self.view).x
            
            //check if swipeing was left or right
            if translation > 0 { //swipe right
                
                if viewConstraint.constant < 20 {
                    UIView.animate(withDuration: 0.3) {
                        self.viewConstraint.constant += translation / 10
                        self.view.layoutIfNeeded()
                    }
                }
                
            } else { //swipe left
                 if viewConstraint.constant > -165 {
                    UIView.animate(withDuration: 0.3) {
                        self.viewConstraint.constant += translation / 10
                        self.view.layoutIfNeeded()
                    }
                }
            }
            
        } else if sender.state == .ended {
            if viewConstraint.constant < -90 {
                UIView.animate(withDuration: 0.3) {
                    self.viewConstraint.constant = -165
                    self.view.layoutIfNeeded()
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.viewConstraint.constant = 0
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    func fetchSearchDetails(searchValue: String) {
        search = []
        searchID = []
        searchImage = []
        let searchURL = "https://www.omdbapi.com/?apikey=2084636&s=\(searchValue)"
        guard let url = URL(string: searchURL) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let json = try JSONDecoder().decode(SearchMovies.self, from: data)
                for i in 0..<json.Search.count {
                    if !self.search.contains(json.Search[i].Title) {
                        self.search.append(json.Search[i].Title)
                        self.searchID.append(json.Search[i].imdbID)
                        self.searchImage.append(json.Search[i].Poster)
                    }
                }
                print("I RUN BABY")
            } catch let error {
                print("\(error)")
                self.track = 1
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
            }.resume()
    }
    
}

extension MoviesVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchMovies()
    }
    
    @objc func searchMovies() {
        let searchText = searchBar.text!
        
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        let search: String = trimmed.replacingOccurrences(of: " ", with: "+", options: .regularExpression)
        print("\(search)")
        fetchSearchDetails(searchValue: search)
    }
}


extension MoviesVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !search.isEmpty {
            return search.count
        } else if track == 1{
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moviesCell", for: indexPath) as! MoviesCell
        
        if !search.isEmpty {
            cell.favBtn.isHidden = false
            cell.update(name: search[indexPath.row])
        } else if track == 1{
            cell.update(name: "No result found!")
            cell.favBtn.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "movieDetailVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "movieDetailVC" {
            if self.tableView.indexPathForSelectedRow != nil {
                let indexPath = self.tableView.indexPathForSelectedRow?.row
                let controller = segue.destination as! MovieDetailVC
                print(controller.view)
                getFullMovieDetail(id: searchID[indexPath!]) { (success) in
                    if success {
                        self.getImage(url: self.searchImage[indexPath!])
                        DispatchQueue.main.async {
                            controller.movieImageView.image = self.newImage
                            controller.movieImageView2.image = self.newImage
                            controller.movieName.text = self.movieDetails.Title
                            controller.moviewGenre.text = self.movieDetails.Genre
                            controller.movieDetail.text = self.movieDetails.Plot
                            controller.movieLanguage.text = self.movieDetails.Language
                            controller.activityInticator.stopAnimating()
                            controller.shadowView.isHidden = true
                            controller.activityInticator.isHidden = true
                        }
                    }
                }
            }
        }
    }
    
    func getImage(url: String) {
        
        if let URL1 = URL(string: url) {
            
            let data = try? Data(contentsOf: URL1)
            if data != nil {
                let image = UIImage(data: data!, scale: UIScreen.main.scale)
                newImage = image
            } else {
                //                https://umexpert.um.edu.my/Avatar/no-image-found.jpg
                let URL2 = URL(string: "https://umexpert.um.edu.my/Avatar/no-image-found.jpg")
                let data = try? Data(contentsOf: URL2!)
                let image = UIImage(data: data!, scale: UIScreen.main.scale)
                newImage = image
            }
            
            
        }
        
    }
    
    func getFullMovieDetail(id: String, completion: @escaping (_ handler: Bool) -> ()) {
        let urlString = "https://www.omdbapi.com/?apikey=2084636&i=\(id)"
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let json = try JSONDecoder().decode(MovieDetails.self, from: data)
                self.movieDetails = json
                completion(true)
            } catch let error {
                print("\(error)")
                completion(false)
            }
            
            
            
            }.resume()
    }
}











