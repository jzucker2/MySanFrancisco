//
//  FirstViewController.swift
//  MySanFrancisco
//
//  Created by Jordan Zucker on 8/16/16.
//  Copyright © 2016 Jordan Zucker. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreData

class FirstViewController: UIViewController, GMSMapViewDelegate, NSFetchedResultsControllerDelegate {
    var mapView: GMSMapView?
    var fetchedResultsController: NSFetchedResultsController<Spot>?
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 1.285, longitude: 103.848, zoom: 12)
        let loadingMapView = GMSMapView.map(withFrame: .zero, camera: camera)
        loadingMapView.isMyLocationEnabled = true
        loadingMapView.padding = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 300.0, right: 5.0)
        loadingMapView.settings.compassButton = true
        loadingMapView.settings.myLocationButton = true
        loadingMapView.delegate = self
        self.mapView = loadingMapView
        self.view = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let fetchRequest: NSFetchRequest<Spot> = Spot.fetchRequest()
        let creationDateSortDescriptor = NSSortDescriptor(key: #keyPath(Spot.creationDate), ascending: true)
        fetchRequest.sortDescriptors = [creationDateSortDescriptor]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
        configureAnnotations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI
    
    func configureAnnotations() {
//        guard let configuringMapView = mapView else {
//            fatalError()
//        }
        mapView?.clear() // what can we do about this?
        guard let spots = fetchedResultsController?.fetchedObjects else {
            return
        }
        spots.forEach { (spot) in
//            let spotMarker = GMSMarker(position: spot.location)
//            spotMarker.icon = GMSMarker.markerImage(with: UIColor.red)
//            spotMarker.map = self.mapView
            addMarker(for: spot)
            
            
        }
    }
    
    // MARK: - GMSMapViewDelegate
    
    public func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print(#function)
    }
    
    public func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        print(#function)
//        let staircaseAddViewController = StairCaseAddViewController(coordinate: coordinate)
//        present(staircaseAddViewController, animated: true)
        let addSpotViewController = SpotAddViewController.createInNavigationController(coordinate: coordinate)
        present(addSpotViewController, animated: true)
    }
    
    public func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print(#function)
        return true
    }

    // MARK: NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.beginUpdates()
    }
    
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
//        switch type {
//        case .insert:
//            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
//        case .delete:
//            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
//        case .move:
//            break
//        case .update:
//            break
//        }
//    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard let spot = anObject as? Spot else {
            return
        }
        switch type {
        case .insert:
            addMarker(for: spot)
//            tableView.insertRows(at: [newIndexPath!], with: .fade)
            return
        case .delete:
//            tableView.deleteRows(at: [indexPath!], with: .fade)
            removeMarker(for: spot)
            return
        case .update:
//            guard let cell = tableView.cellForRow(at: indexPath!) else {
//                fatalError()
//            }
//            configureCell(cell: cell, indexPath: indexPath!)
            updateMarker(for: spot)
            return
        case .move:
//            tableView.moveRow(at: indexPath!, to: newIndexPath!)
            return
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.endUpdates()
    }
    
    func addMarker(for spot: Spot) {
        guard let configuringMapView = mapView else {
            fatalError()
        }
        let _ = spot.marker(in: configuringMapView)
    }
    
    func removeMarker(for spot: Spot) {
        guard let configuringMapView = mapView else {
            fatalError()
        }
        let _ = spot.remove(from: configuringMapView)
    }
    
    func updateMarker(for spot: Spot) {
        removeMarker(for: spot)
        addMarker(for: spot)
    }
}

