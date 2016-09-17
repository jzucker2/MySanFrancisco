//
//  Picture+CoreDataProperties.swift
//  MySanFrancisco
//
//  Created by Jordan Zucker on 9/16/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

import Foundation
import CoreData


extension Picture {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Picture> {
        return NSFetchRequest<Picture>(entityName: "Picture");
    }

    @NSManaged public var creationDate: NSDate
    @NSManaged public var title: String?
    @NSManaged public var caption: String?
    @NSManaged public var data: NSData
    @NSManaged public var spot: Spot?

}
