//
//  Movie+CoreDataClass.swift
//  Zwei
//
//  Created by Ralph Angelo Bautista on 07/05/2017.
//  Copyright © 2017 Ralph Angelo Bautista. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON


public class Movie: NSManagedObject {
    class func movieWithInfo(info: JSON, inManagedObjectContext context: NSManagedObjectContext) -> Movie? {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", info["imdbID"].stringValue)
        
        if let movie = (try? context.fetch(request))?.first {
            return movie
        }else if let movie = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: context) as? Movie{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            
            movie.id = info["imdbID"].stringValue
            movie.title = info["Title"].stringValue
            movie.synopsis = info["Plot"].stringValue
            movie.thumbnail = info["Poster"].stringValue
            movie.isFavorite = false
            movie.rating = Int32(Float(info["imdbRating"].stringValue)! * 10.0)
            movie.releaseDate = dateFormatter.date(from: info["Released"].stringValue) as NSDate?
            movie.trailerDate = dateFormatter.date(from: info["Released"].stringValue) as NSDate?
            movie.addToDirectors(NSSet(array: Director.directorsWithInfo(info: info["Director"].stringValue, inManagedObjectContext: context)))
            movie.addToCasts(NSSet(array: Cast.castsWithInfo(info: info["Actors"].stringValue, inManagedObjectContext: context)))
            movie.addToGenres(NSSet(array: Genre.genresWithInfo(info: info["Genre"].stringValue, inManagedObjectContext: context)))
            
            return movie
        }
        
        return nil
    }
}
