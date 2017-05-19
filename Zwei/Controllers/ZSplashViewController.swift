//
//  ZSplashViewController.swift
//  Zwei
//
//  Created by Ralph Angelo Bautista on 06/05/2017.
//  Copyright © 2017 Ralph Angelo Bautista. All rights reserved.
//

import UIKit
import CoreData

import SwiftyJSON

class ZSplashViewController: UIViewController {
    
    var managedObjectContext: NSManagedObjectContext? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    var splashView: ZSplashScreen?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let view = self.loadFromXib(XIB.SplashXIBName.rawValue)
        
        if let v = view as? ZSplashScreen {
            self.splashView = v
            self.splashView?.progressBar?.isHidden = false
            self.splashView?.progressBar?.progress = 0.0
            
            
            self.view = self.splashView
        }
        
        // Do any additional setup after loading the view.
        
        loadMovies()
        loadSeries()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func checkProgress(){
        if let progressBar = self.splashView?.progressBar {
            if progressBar.progress == 1 {
                DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + DispatchTimeInterval.milliseconds(250)), execute: {
                    weak var weakSelf = self
                    weakSelf?.performSegue(withIdentifier: Segue.SplashToHomeSegue.rawValue, sender: self)
                })
            }
        }
    }
    
    private func loadMovies(){
        let json = self.loadJSONFromFile(file: "movies", withExtension: "json")
        if let movies = json?.array {
            let incr = 0.5 / Float(movies.count)
            for movie in movies {
                _ = Movie.movieWithInfo(info: movie, inManagedObjectContext: managedObjectContext!)
                self.splashView?.progressBar?.progress += incr
                self.checkProgress()
            }
            
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.saveContext()
            }
        }
    }
    
    private func loadSeries(){
        let json = self.loadJSONFromFile(file: "series", withExtension: "json")
        if let series = json?.array {
            let incr = 0.5 / Float(series.count)
            for show in series {
                _ = Series.seriesWithInfo(info: show, inManagedObjectContext: managedObjectContext!)
                self.splashView?.progressBar?.progress += incr
                self.checkProgress()
            }
            
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.saveContext()
            }
        }
        
    }
    
    private func loadJSONFromFile(file: String, withExtension fileExtension: String) -> JSON? {
    
        var json: JSON?
        
        do {
            json = try JSON(data: Data(contentsOf: Bundle.main.url(forResource: file, withExtension: fileExtension)!))
        } catch {
            print(error.localizedDescription)
        }
        
        return json
    }
}
