//
//  SeriesViewController.swift
//  Zwei
//
//  Created by Ralph Angelo Bautista on 15/05/2017.
//  Copyright © 2017 Ralph Angelo Bautista. All rights reserved.
//

import UIKit
import CoreData

class SeriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let managedContext: NSManagedObjectContext? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    var showsTableView: ShowsTableView!
    var series: [Series]? {
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
    
    private func setupView() {
        navigationItem.title = "Series"
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "icon_menu"), style: .plain, target: self, action: #selector(showMenu))
        menuButton.tintColor = .lightGray
        navigationItem.leftBarButtonItem = menuButton
        
        showsTableView = loadFromXib(XIB.ShowsTableView.rawValue) as! ShowsTableView
        showsTableView?.showsTableView.register(UINib(nibName: "ShowsTableViewCell", bundle: nil), forCellReuseIdentifier: "ShowsTableViewCell")
        showsTableView?.showsTableView.estimatedRowHeight = 70.0;
        showsTableView?.showsTableView.rowHeight = UITableViewAutomaticDimension;
        showsTableView?.showsTableView.tableFooterView = UIView()
        showsTableView?.showsTableView.dataSource = self
        showsTableView?.showsTableView.delegate = self
        
        view = showsTableView
    }

    func reload() {
        let fetchRequest:NSFetchRequest<Series> = Series.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "runDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        managedContext?.perform({ [weak weakSelf = self] in
            weakSelf?.series = try! weakSelf?.managedContext?.fetch(fetchRequest)
        })
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = series?.count, count > 0 {
            return count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let show = series?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowsTableViewCell") as! ShowsTableViewCell

        var url = URL(string: "http://xiostorage.com/wp-content/uploads/2015/10/test.png")
        
        if let poster = show?.thumbnail {
            url = URL(string: poster)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        cell.thumbnail.sd_setImage(with: url)
        cell.title.text = show?.title
        
        if let rating = show?.rating {
            cell.rating.text = "\(rating)"
        }
        
        var genreString = ""
        var directorString = ""
        var castString = ""
        
        var genre: [String] = []
        var director: [String] = []
        var cast: [String] = []
        
        if let genres = show?.genres {
            for g in genres {
                if let gInstance = g as? Genre {
                    genre.append(gInstance.name!)
                }
            }
        }
        
        if let directors = show?.directors {
            for d in directors {
                if let dInstance = d as? Director {
                    director.append(dInstance.name!)
                }
            }
        }
        
        if let casts = show?.casts {
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
        
        if let date = show?.runDate! {
            cell.subtitle.text = dateFormatter.string(from: date as Date)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segue.SeriesDetailsSegue.rawValue, sender: indexPath)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let seriesDetailsViewController = segue.destination as? SeriesDetailsViewController, let indexPath = showsTableView?.showsTableView.indexPathForSelectedRow {
            seriesDetailsViewController.series = series?[indexPath.row]
        }
    }

}
