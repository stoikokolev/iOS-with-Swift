//
//  MapViewController.swift
//  Bilbo's Diary
//
//  Created by Veronica Velkova on 11.10.20.
//

import UIKit
import MapKit
import CoreData
import CoreLocation


class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    // TODO: - DI for managedObjectContext
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK:- Actions
    @IBAction func showUser() {
        // TODO: - Show current user location
    }
    
    @IBAction func showLocations() {
        // TODO: - Show Locatios - set region and show it
    }
    
    // MARK:- Helper methods
    func updateLocations() {
        // TODO: - Fetch locations, display annotations
    }
    
    func region(for annotations: [MKAnnotation]) ->
    MKCoordinateRegion {
        // TODO: - Calculate region that needs to be visible
        MKCoordinateRegion()
    }
}

extension MapViewController: MKMapViewDelegate {
}
