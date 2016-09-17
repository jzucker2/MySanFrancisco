//
//  Spot+CoreDataClass.swift
//  MySanFrancisco
//
//  Created by Jordan Zucker on 9/16/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

import Foundation
import CoreData
import GoogleMaps

@objc(Spot)
public class Spot: NSManagedObject {
    
    // maybe try this later?
    // http://stackoverflow.com/questions/24127587/how-do-i-declare-an-array-of-weak-references-in-swift
    var maps: Set<GMSMapView>?
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        creationDate = NSDate()
    }
    
    // if mapView is nil, then marker is still created
    func marker(in mapView: GMSMapView?) -> GMSMarker {
        let marker = GMSMarker(position: location)
        guard let markingMapView = mapView else {
            return marker
        }
        marker.map = markingMapView
        maps?.insert(markingMapView)
        return marker
    }
    
    func remove(marker: GMSMarker, from mapView: GMSMapView) {
        let _ = remove(from: mapView)
        marker.map = nil
    }
    
    func remove(from mapView: GMSMapView) -> GMSMapView? {
        return maps?.remove(mapView)
    }
    
    public override func awakeFromFetch() {
        super.awakeFromFetch()
        maps = Set<GMSMapView>()
    }
    
    public override func didTurnIntoFault() {
        maps?.removeAll()
        maps = nil
        super.didTurnIntoFault()
    }

}
