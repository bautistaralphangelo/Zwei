//
//  Movie+CoreDataProperties.swift
//  
//
//  Created by Ralph Angelo Bautista on 10/05/2017.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie");
    }

    @NSManaged public var id: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var rating: Int32
    @NSManaged public var releaseDate: NSDate?
    @NSManaged public var synopsis: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var title: String?
    @NSManaged public var trailerDate: NSDate?
    @NSManaged public var casts: NSSet?
    @NSManaged public var directors: NSSet?
    @NSManaged public var genres: NSSet?
    @NSManaged public var related: NSSet?

}

// MARK: Generated accessors for casts
extension Movie {

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
extension Movie {

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
extension Movie {

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: Genre)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: Genre)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)

}

// MARK: Generated accessors for related
extension Movie {

    @objc(addRelatedObject:)
    @NSManaged public func addToRelated(_ value: Movie)

    @objc(removeRelatedObject:)
    @NSManaged public func removeFromRelated(_ value: Movie)

    @objc(addRelated:)
    @NSManaged public func addToRelated(_ values: NSSet)

    @objc(removeRelated:)
    @NSManaged public func removeFromRelated(_ values: NSSet)

}
