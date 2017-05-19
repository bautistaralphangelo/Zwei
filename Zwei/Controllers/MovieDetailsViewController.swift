//
//  MovieDetailsViewController.swift
//  Zwei
//
//  Created by Ralph Angelo Bautista on 09/05/2017.
//  Copyright © 2017 Ralph Angelo Bautista. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController, UITableViewDataSource {
    
    var movieDetailsView: MovieDetailsView?
    var movie: Movie?
    var cast: [String] = [] {
        didSet {
            reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let v = loadFromXib(XIB.MovieDetailsView.rawValue) as? MovieDetailsView! {
            movieDetailsView = v
            movieDetailsView?.castTableView.dataSource = self
            
            setupView()
            
            view = movieDetailsView!
        }
        
        // Do any additional setup after loading the view.
    }
    
    func onClick() {
        let isFavorite = !(movie?.isFavorite)!
        
        movie?.managedObjectContext?.performAndWait {[weak weakSelf = self] in
            weakSelf?.movie?.isFavorite = isFavorite
            
            do {
                try weakSelf?.movie?.managedObjectContext?.save()
                weakSelf?.toggleFavoriteIconColor(isFavorite: isFavorite)
            } catch _ {
                
            }
        }
    }
    
    func toggleFavoriteIconColor(isFavorite:Bool) {
        DispatchQueue.main.async { [weak weakSelf = self] in
            let color = isFavorite ? UIColor.yellow : UIColor.lightGray
            weakSelf?.movieDetailsView?.favoriteIcon.tintColor = color
        }
    }
    
    private func setupView(){
        
        movieDetailsView?.movieTitle.text = movie?.title
        if let rating = movie?.rating {
            movieDetailsView?.rating.text = "\(rating)"
        }else{
            movieDetailsView?.rating.text = "NA"
        }
        
        let onClickHandler = UITapGestureRecognizer(target: self, action: #selector(onClick))
        onClickHandler.numberOfTapsRequired = 1
        movieDetailsView?.favoriteIcon.isUserInteractionEnabled = true
        movieDetailsView?.favoriteIcon.addGestureRecognizer(onClickHandler)
        
        toggleFavoriteIconColor(isFavorite: (movie?.isFavorite)!)
        
        var url = URL(string: "http://xiostorage.com/wp-content/uploads/2015/10/test.png")
        if let poster = movie?.thumbnail {
            url = URL(string: poster)
        }
        movieDetailsView?.posterImageView.sd_setImage(with: url)
        movieDetailsView?.plot.text = movie?.synopsis
        
        var genreString = ""
        var directorString = ""
        var genre: [String] = []
        var director: [String] = []
        
        if let genres = movie?.genres {
            for g in genres {
                if let gInstance = g as? Genre {
                    genre.append(gInstance.name!)
                }
            }
        }
        
        if let directors = movie?.directors {
            for d in directors {
                if let dInstance = d as? Director {
                    director.append(dInstance.name!)
                }
            }
        }
        
        var cast: [String] = []
        
        if let genres = movie?.genres {
            for g in genres {
                if let gInstance = g as? Genre {
                    genre.append(gInstance.name!)
                }
            }
        }
        
        if let directors = movie?.directors {
            for d in directors {
                if let dInstance = d as? Director {
                    director.append(dInstance.name!)
                }
            }
        }
        
        if let casts = movie?.casts {
            for c in casts {
                if let cInstance = c as? Cast {
                    cast.append(cInstance.name!)
                }
            }
            
            self.cast = cast
        }

        if genre.count > 0 {
            genreString = genre.joined(separator: ", ")
        }
        
        if director.count > 0 {
            directorString = director.joined(separator: ", ")
        }
        
        movieDetailsView?.genre.text = genreString
        movieDetailsView?.director.text = directorString
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        if let date = movie?.releaseDate! {
            movieDetailsView?.releaseDate.text = dateFormatter.string(from: date as Date)
        }
    }
    
    private func reloadData(){
        movieDetailsView?.castTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        if (!cell) {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        }
        
        var cell: UITableViewCell
        
        if let c = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell = c
        }else{
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell.textLabel?.text = cast[indexPath.row]
        
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
