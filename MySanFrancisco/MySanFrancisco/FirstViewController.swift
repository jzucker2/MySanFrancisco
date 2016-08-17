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

class FirstViewController: UIViewController, GMSMapViewDelegate {
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 1.285, longitude: 103.848, zoom: 12)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.padding = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 300.0, right: 5.0)
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        self.view = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - GMSMapViewDelegate
    
    public func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print(#function)
    }
    
    public func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        print(#function)
        let staircaseAddViewController = StairCaseAddViewController(coordinate: coordinate)
        present(staircaseAddViewController, animated: true)
    }
    
    public func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print(#function)
        return true
    }


}

