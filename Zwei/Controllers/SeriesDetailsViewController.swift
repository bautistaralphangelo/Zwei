//
//  SeriesDetailsViewController.swift
//  Zwei
//
//  Created by Ralph Angelo Bautista on 16/05/2017.
//  Copyright © 2017 Ralph Angelo Bautista. All rights reserved.
//

import UIKit

class SeriesDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var seriesDetailsView: SeriesDetailsView!
    var series: Series!
    var cast: [String] = [] {
        didSet {
            reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let v = loadFromXib(XIB.SeriesDetailsView.rawValue) as? SeriesDetailsView {
            seriesDetailsView = v
            seriesDetailsView?.castTableView.dataSource = self
            
            setupView()
            
            view = seriesDetailsView
        }
    }
    
    func onClick() {
        let isFavorite = !(series?.isFavorite)!
        
        series?.managedObjectContext?.performAndWait {[weak weakSelf = self] in
            weakSelf?.series?.isFavorite = isFavorite
            
            do {
                try weakSelf?.series?.managedObjectContext?.save()
                weakSelf?.toggleFavoriteIconColor(isFavorite: isFavorite)
            } catch _ {
                
            }
        }
    }
    
    func toggleFavoriteIconColor(isFavorite:Bool) {
        DispatchQueue.main.async { [weak weakSelf = self] in
            let color = isFavorite ? UIColor.yellow : UIColor.lightGray
            weakSelf?.seriesDetailsView?.favoriteIcon.tintColor = color
        }
    }

    
    func setupView() {
        seriesDetailsView?.title.text = series?.title
        if let rating = series?.rating {
            seriesDetailsView?.rating.text = "\(rating)"
        }else{
            seriesDetailsView?.rating.text = "NA"
        }
        
        if let season = series?.season {
            seriesDetailsView?.seasons.text = "\(season)"
        }else{
            seriesDetailsView?.rating.text = "NA"
        }
        
        var url = URL(string: "http://xiostorage.com/wp-content/uploads/2015/10/test.png")
        if let poster = series?.thumbnail {
            url = URL(string: poster)
        }
        seriesDetailsView?.posterImageView.sd_setImage(with: url)
        seriesDetailsView?.plot.text = series?.synopsis
        
        let onClickHandler = UITapGestureRecognizer(target: self, action: #selector(onClick))
        onClickHandler.numberOfTapsRequired = 1
        seriesDetailsView?.favoriteIcon.isUserInteractionEnabled = true
        seriesDetailsView?.favoriteIcon.addGestureRecognizer(onClickHandler)
        
        toggleFavoriteIconColor(isFavorite: (series?.isFavorite)!)
        
        var genreString = ""
        var directorString = ""
        var genre: [String] = []
        var director: [String] = []
        
        var cast: [String] = []
        
        if let genres = series?.genres {
            for g in genres {
                if let gInstance = g as? Genre {
                    genre.append(gInstance.name!)
                }
            }
        }
        
        if let directors = series?.directors {
            for d in directors {
                if let dInstance = d as? Director {
                    director.append(dInstance.name!)
                }
            }
        }
        
        if let casts = series?.casts {
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
        
        seriesDetailsView?.genre.text = genreString
        seriesDetailsView?.director.text = directorString
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        if let date = series?.runDate! {
            seriesDetailsView?.releaseDate.text = dateFormatter.string(from: date as Date)
        }
    }
    
    func reloadData() {
            seriesDetailsView?.castTableView.reloadData()
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        if let c = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell = c
        }else{
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell.textLabel?.text = cast[indexPath.row]
        
        return cell
    }
    
    // MARK: - UITableViewDelegate

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
