//
//  Director+CoreDataProperties.swift
//  
//
//  Created by Ralph Angelo Bautista on 10/05/2017.
//
//

import Foundation
import CoreData


extension Director {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Director> {
        return NSFetchRequest<Director>(entityName: "Director");
    }

    @NSManaged public var name: String?
    @NSManaged public var movieDirected: NSSet?
    @NSManaged public var seriesDirected: NSSet?

}

// MARK: Generated accessors for movieDirected
extension Director {

    @objc(addMovieDirectedObject:)
    @NSManaged public func addToMovieDirected(_ value: Movie)

    @objc(removeMovieDirectedObject:)
    @NSManaged public func removeFromMovieDirected(_ value: Movie)

    @objc(addMovieDirected:)
    @NSManaged public func addToMovieDirected(_ values: NSSet)

    @objc(removeMovieDirected:)
    @NSManaged public func removeFromMovieDirected(_ values: NSSet)

}

// MARK: Generated accessors for seriesDirected
extension Director {

    @objc(addSeriesDirectedObject:)
    @NSManaged public func addToSeriesDirected(_ value: Series)

    @objc(removeSeriesDirectedObject:)
    @NSManaged public func removeFromSeriesDirected(_ value: Series)

    @objc(addSeriesDirected:)
    @NSManaged public func addToSeriesDirected(_ values: NSSet)

    @objc(removeSeriesDirected:)
    @NSManaged public func removeFromSeriesDirected(_ values: NSSet)

}
