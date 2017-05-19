//
//  MoviesViewController.swift
//  Zwei
//
//  Created by Ralph Angelo Bautista on 09/05/2017.
//  Copyright © 2017 Ralph Angelo Bautista. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var showsTableView: ShowsTableView?
    
    let managedContext: NSManagedObjectContext? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var movies: [Movie]? {
        didSet {
            showsTableView?.showsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupView()
        reload()
    }
    
    private func setupView(){
        navigationItem.title = "Movies"
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "icon_menu"), style: .plain, target: self, action: #selector(showMenu))
        menuButton.tintColor = .lightGray
        navigationItem.leftBarButtonItem = menuButton
        
        if let v = self.loadFromXib(XIB.ShowsTableView.rawValue) as? ShowsTableView {
            showsTableView = v
            showsTableView?.showsTableView.register(UINib(nibName: "ShowsTableViewCell", bundle: nil), forCellReuseIdentifier: "ShowsTableViewCell")
            showsTableView?.showsTableView.estimatedRowHeight = 70.0;
            showsTableView?.showsTableView.rowHeight = UITableViewAutomaticDimension;
            showsTableView?.showsTableView.tableFooterView = UIView()
            showsTableView?.showsTableView.dataSource = self
            showsTableView?.showsTableView.delegate = self
            
            view = showsTableView
        }
    }
    
    private func reload() {
        let fetchRequest:NSFetchRequest<Movie> = Movie.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "releaseDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        managedContext?.perform({ [weak weakSelf = self] in
            weakSelf?.movies = try! weakSelf?.managedContext?.fetch(fetchRequest)
        })
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = movies?.count, count > 0 {
            return count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowsTableViewCell") as! ShowsTableViewCell
        var url = URL(string: "http://xiostorage.com/wp-content/uploads/2015/10/test.png")
        
        if let poster = movie?.thumbnail! {
            url = URL(string: poster)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        cell.thumbnail.sd_setImage(with: url)
        cell.title.text = movie?.title
        
        if let rating = movie?.rating {
            cell.rating.text = "\(rating)"
        }
        
        var genreString = ""
        var directorString = ""
        var castString = ""
        
        var genre: [String] = []
        var director: [String] = []
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
        }
        
        if genre.count > 0 {
            genreString = genre.joined(separator: ", ")
        }
        
        if director.count > 0 {
            directorString = director.joined(separator: ", ")
        }
        
        if cast.count > 0 {
            castString = cast.joined(separator: ", ")
        }
        
        cell.genre.text = genreString
        cell.director.text = directorString
        cell.cast.text = castString
        
        if let date = movie?.releaseDate! {
            cell.subtitle.text = dateFormatter.string(from: date as Date)
        }
        
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segue.MovieDetailsSegue.rawValue, sender: indexPath)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let movieDetailsViewController = segue.destination as? MovieDetailsViewController, let indexPath = showsTableView?.showsTableView.indexPathForSelectedRow {
            movieDetailsViewController.movie = movies?[indexPath.row]
        }
    }
}
