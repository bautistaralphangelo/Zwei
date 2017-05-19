//
//  Genre+CoreDataProperties.swift
//  
//
//  Created by Ralph Angelo Bautista on 10/05/2017.
//
//

import Foundation
import CoreData


extension Genre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Genre> {
        return NSFetchRequest<Genre>(entityName: "Genre");
    }

    @NSManaged public var name: String?
    @NSManaged public var movieGenre: NSSet?
    @NSManaged public var seriesGenre: NSSet?

}

// MARK: Generated accessors for movieGenre
extension Genre {

    @objc(addMovieGenreObject:)
    @NSManaged public func addToMovieGenre(_ value: Movie)

    @objc(removeMovieGenreObject:)
    @NSManaged public func removeFromMovieGenre(_ value: Movie)

    @objc(addMovieGenre:)
    @NSManaged public func addToMovieGenre(_ values: NSSet)

    @objc(removeMovieGenre:)
    @NSManaged public func removeFromMovieGenre(_ values: NSSet)

}

// MARK: Generated accessors for seriesGenre
extension Genre {

    @objc(addSeriesGenreObject:)
    @NSManaged public func addToSeriesGenre(_ value: Series)

    @objc(removeSeriesGenreObject:)
    @NSManaged public func removeFromSeriesGenre(_ value: Series)

    @objc(addSeriesGenre:)
    @NSManaged public func addToSeriesGenre(_ values: NSSet)

    @objc(removeSeriesGenre:)
    @NSManaged public func removeFromSeriesGenre(_ values: NSSet)

}
