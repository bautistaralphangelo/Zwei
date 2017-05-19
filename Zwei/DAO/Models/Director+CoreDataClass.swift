//
//  Director+CoreDataClass.swift
//  Zwei
//
//  Created by Ralph Angelo Bautista on 06/05/2017.
//  Copyright © 2017 Ralph Angelo Bautista. All rights reserved.
//

import Foundation
import CoreData


public class Director: NSManagedObject {
    class func directorsWithInfo(info: String, inManagedObjectContext context: NSManagedObjectContext) -> [Director] {
        var directors: [Director] = []
        
        let request: NSFetchRequest<Director> = Director.fetchRequest()
        
        for directorItem in info.components(separatedBy: ",") {
            let directorString = directorItem.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            request.predicate = NSPredicate(format: "name = %@", directorString)
            
            if let director = (try? context.fetch(request))?.first {
                directors.append(director)
            }else if let director = NSEntityDescription.insertNewObject(forEntityName: "Director", into: context) as? Director{
                director.name = directorString
                
                directors.append(director)
            }
        }
        
        return directors
    }


}
