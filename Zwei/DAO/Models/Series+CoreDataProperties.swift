//
//  Series+CoreDataProperties.swift
//  
//
//  Created by Ralph Angelo Bautista on 10/05/2017.
//
//

import Foundation
import CoreData


extension Series {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Series> {
        return NSFetchRequest<Series>(entityName: "Series");
    }

    @NSManaged public var id: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var rating: Int32
    @NSManaged public var runDate: NSDate?
    @NSManaged public var season: NSDecimalNumber?
    @NSManaged public var synopsis: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var title: String?
    @NSManaged public var casts: NSSet?
    @NSManaged public var directors: NSSet?
    @NSManaged public var genres: NSSet?

}

// MARK: Generated accessors for casts
extension Series {

    @objc(addCastsObject:)
    @NSManaged public func addToCasts(_ value: Cast)

    @objc(removeCastsObject:)
    @NSManaged public func removeFromCasts(_ value: Cast)

    @objc(addCasts:)
    @NSManaged public func addToCasts(_ values: NSSet)

    @objc(removeCasts:)
    @NSManaged public func removeFromCasts(_ values: NSSet)

}

// MARK: Generated accessors for directors
extension Series {

    @objc(addDirectorsObject:)
    @NSManaged public func addToDirectors(_ value: Director)

    @objc(removeDirectorsObject:)
    @NSManaged public func removeFromDirectors(_ value: Director)

    @objc(addDirectors:)
    @NSManaged public func addToDirectors(_ values: NSSet)

    @objc(removeDirectors:)
    @NSManaged public func removeFromDirectors(_ values: NSSet)

}

// MARK: Generated accessors for genres
extension Series {

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: Genre)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: Genre)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)

}
