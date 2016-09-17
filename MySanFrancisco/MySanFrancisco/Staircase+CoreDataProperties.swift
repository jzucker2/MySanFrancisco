//
//  Staircase+CoreDataProperties.swift
//  MySanFrancisco
//
//  Created by Jordan Zucker on 9/16/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

import Foundation
import CoreData


extension Staircase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Staircase> {
        return NSFetchRequest<Staircase>(entityName: "Staircase");
    }


}
