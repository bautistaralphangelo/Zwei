//
//  Genre+CoreDataClass.swift
//  Zwei
//
//  Created by Ralph Angelo Bautista on 06/05/2017.
//  Copyright © 2017 Ralph Angelo Bautista. All rights reserved.
//

import Foundation
import CoreData


public class Genre: NSManagedObject {
    
    class func genresWithInfo(info: String, inManagedObjectContext context: NSManagedObjectContext) -> [Genre] {
        var genres: [Genre] = []
        
        let request: NSFetchRequest<Genre> = Genre.fetchRequest()
        
        for genreItem in info.components(separatedBy: ",") {
            let genreString = genreItem.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            request.predicate = NSPredicate(format: "name = %@", genreString)
            
            if let genre = (try? context.fetch(request))?.first {
                genres.append(genre)
            }else if let genre = NSEntityDescription.insertNewObject(forEntityName: "Genre", into: context) as? Genre{
                genre.name = genreString
                
                genres.append(genre)
            }
        }
    
        return genres
    }

    
}
