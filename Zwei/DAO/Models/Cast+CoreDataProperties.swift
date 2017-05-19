//
//  Cast+CoreDataProperties.swift
//  
//
//  Created by Ralph Angelo Bautista on 10/05/2017.
//
//

import Foundation
import CoreData


extension Cast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cast> {
        return NSFetchRequest<Cast>(entityName: "Cast");
    }

    @NSManaged public var name: String?
    @NSManaged public var movieCast: NSSet?
    @NSManaged public var seriesCast: NSSet?

}

// MARK: Generated accessors for movieCast
extension Cast {

    @objc(addMovieCastObject:)
    @NSManaged public func addToMovieCast(_ value: Movie)

    @objc(removeMovieCastObject:)
    @NSManaged public func removeFromMovieCast(_ value: Movie)

    @objc(addMovieCast:)
    @NSManaged public func addToMovieCast(_ values: NSSet)

    @objc(removeMovieCast:)
    @NSManaged public func removeFromMovieCast(_ values: NSSet)

}

// MARK: Generated accessors for seriesCast
extension Cast {

    @objc(addSeriesCastObject:)
    @NSManaged public func addToSeriesCast(_ value: Series)

    @objc(removeSeriesCastObject:)
    @NSManaged public func removeFromSeriesCast(_ value: Series)

    @objc(addSeriesCast:)
    @NSManaged public func addToSeriesCast(_ values: NSSet)

    @objc(removeSeriesCast:)
    @NSManaged public func removeFromSeriesCast(_ values: NSSet)

}
