//
//  Location+CoreDataClass.swift
//  Bilbo's Diary
//
//  Created by Stoyko Kolev on 10.01.21.
//
//

import Foundation
import CoreData
import MapKit

@objc(Location)
public class Location: NSManagedObject, MKAnnotation {
    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public var title: String? {
        if descriptionText.isEmpty {
            return "No description"
        } else {
            return descriptionText
        }
    }
    
    public var subtitle: String? {
        return category
    }
}
