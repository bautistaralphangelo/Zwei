//
//  Series+CoreDataClass.swift
//  Zwei
//
//  Created by Ralph Angelo Bautista on 07/05/2017.
//  Copyright © 2017 Ralph Angelo Bautista. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

public class Series: NSManagedObject {
    class func seriesWithInfo(info: JSON, inManagedObjectContext context: NSManagedObjectContext) -> Series? {
        let request: NSFetchRequest<Series> = Series.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", info["imdbID"].stringValue)
        
        if let series = (try? context.fetch(request))?.first {
            return series
        }else if let series = NSEntityDescription.insertNewObject(forEntityName: "Series", into: context) as? Series{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            
            series.id = info["imdbID"].stringValue
            series.title = info["Title"].stringValue
            series.synopsis = info["Plot"].stringValue
            series.thumbnail = info["Poster"].stringValue
            series.isFavorite = false
            series.rating = Int32(Float(info["imdbRating"].stringValue)! * 10.0)
            series.season = NSDecimalNumber(string: info["totalSeasons"].stringValue)
            series.runDate = dateFormatter.date(from: info["Released"].stringValue) as NSDate?
            series.addToDirectors(NSSet(array: Director.directorsWithInfo(info: info["Director"].stringValue, inManagedObjectContext: context)))
            series.addToCasts(NSSet(array: Cast.castsWithInfo(info: info["Actors"].stringValue, inManagedObjectContext: context)))
            series.addToGenres(NSSet(array: Genre.genresWithInfo(info: info["Genre"].stringValue, inManagedObjectContext: context)))
            
            return series
        }
        
        return nil
    }
    
}
