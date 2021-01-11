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
    var managedObjectContext: NSManagedObjectContext!
    var locations: [Location] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateLocations()
        
        if !locations.isEmpty {
            showLocations()
        }
    }
    
    // MARK:- Actions
    @IBAction func showUser() {
        // TODO: - Show current user location
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func showLocations() {
        // TODO: - Show Locatios - set region and show it
        let theRegion = region(for: locations)
        mapView.setRegion(theRegion, animated: true)
    }
    
    // MARK:- Helper methods
    func updateLocations() {
        // TODO: - Fetch locations, display annotations
        mapView.removeAnnotations(locations)
        let entity = Location.entity()
        let fetchRequest = NSFetchRequest<Location>()
        fetchRequest.entity = entity
        
        locations = try! managedObjectContext.fetch(fetchRequest)
        mapView.addAnnotations(locations)
    }
    
    func region(for annotations: [MKAnnotation]) ->
    MKCoordinateRegion {
        // TODO: - Calculate region that needs to be visible
        let region: MKCoordinateRegion
        switch annotations.count {
        case 0:
            region = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        case 1:
            let annotation = annotations[annotations.count-1]
            region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            break
        default:
            var topLeft = CLLocationCoordinate2D(latitude: -90, longitude: 180)
            var bottomRight = CLLocationCoordinate2D(latitude: 90, longitude: -180)
            
            for annotation in annotations {
                topLeft.latitude = max(topLeft.latitude, annotation.coordinate.latitude)
                topLeft.longitude = min(topLeft.longitude, annotation.coordinate.longitude)
                
                bottomRight.latitude = min(bottomRight.latitude, annotation.coordinate.latitude)
                bottomRight.longitude = max(bottomRight.longitude, annotation.coordinate.longitude)
            }
            
            let center = CLLocationCoordinate2D(latitude: topLeft.latitude - (topLeft.latitude - bottomRight.latitude) / 2, longitude: topLeft.longitude - (topLeft.longitude - bottomRight.longitude) / 2)
            let extraSpace = 1.5
            let span = MKCoordinateSpan(latitudeDelta: abs(topLeft.latitude - bottomRight.latitude) * extraSpace, longitudeDelta: abs(topLeft.longitude - bottomRight.longitude) * extraSpace)
            
            region = MKCoordinateRegion(center: center, span: span)
        }
        return mapView.regionThatFits(region)
    }
}

extension MapViewController: MKMapViewDelegate {
}
