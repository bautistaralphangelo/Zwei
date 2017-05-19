//
//  Cast+CoreDataClass.swift
//  Zwei
//
//  Created by Ralph Angelo Bautista on 06/05/2017.
//  Copyright © 2017 Ralph Angelo Bautista. All rights reserved.
//

import Foundation
import CoreData


public class Cast: NSManagedObject {
    
    class func castsWithInfo(info: String, inManagedObjectContext context: NSManagedObjectContext) -> [Cast] {
        var casts: [Cast] = []
        
        let request: NSFetchRequest<Cast> = Cast.fetchRequest()
        
        for actor in info.components(separatedBy: ",") {
            let castString = actor.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            request.predicate = NSPredicate(format: "name = %@", castString)
            
            if let cast = (try? context.fetch(request))?.first {
                casts.append(cast)
            }else if let cast = NSEntityDescription.insertNewObject(forEntityName: "Cast", into: context) as? Cast{
                cast.name = castString
                
                casts.append(cast)
            }
        }
        
        return casts
    }

}
