//
//  Spot+CoreDataProperties.swift
//  MySanFrancisco
//
//  Created by Jordan Zucker on 9/16/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation
import GoogleMaps

extension Spot {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Spot> {
        return NSFetchRequest<Spot>(entityName: "Spot");
    }

    @NSManaged public var title: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var nickname: String
    @NSManaged public var creationDate: NSDate
    @NSManaged public var pictures: Picture?
    
    var location: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
