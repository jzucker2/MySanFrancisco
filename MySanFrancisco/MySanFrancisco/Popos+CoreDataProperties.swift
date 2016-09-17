//
//  Popos+CoreDataProperties.swift
//  MySanFrancisco
//
//  Created by Jordan Zucker on 9/16/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

import Foundation
import CoreData


extension Popos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Popos> {
        return NSFetchRequest<Popos>(entityName: "Popos");
    }

    @NSManaged public var accessInstructions: String?

}
