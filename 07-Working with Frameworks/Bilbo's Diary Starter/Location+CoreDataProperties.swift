//
//  Location+CoreDataProperties.swift
//  Bilbo's Diary
//
//  Created by Stoyko Kolev on 10.01.21.
//
//

import Foundation
import CoreData
import CoreLocation


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var date: Date
    @NSManaged public var category: String
    @NSManaged public var descriptionText: String
    @NSManaged public var placemark: CLPlacemark?

}

extension Location : Identifiable {

}
