//
//  LocationDetailTableViewController.swift
//  My Location
//
//  Created by Veronica Velkova on 8.10.20.
//

import UIKit
import CoreLocation
import CoreData

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()

class LocationDetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var placemark: CLPlacemark?
    var categoryName = "On an Adventure"
    
    // TODO: - Add property for object that's editing
    var descriptionText: String?
    
    var date = Date()
    
    // TODO: - Inject managedObjectContext
    var managedObjectContext: NSManagedObjectContext!
    var locationToEdit: Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // TODO: - Change title if editing
        if let location = locationToEdit {
            title = "Edit Location"
            descriptionText = location.descriptionText
            categoryName = location.category
            coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            placemark = location.placemark
            date = location.date
        }
        descriptionTextView.text = descriptionText ?? ""
        categoryLabel.text = categoryName
        latitudeLabel.text = String(format: "%.8f", coordinate.latitude)
        longitudeLabel.text = String(format: "%.8f", coordinate.longitude)
        
        if let placemark = placemark {
            addressLabel.text = """
                    \(placemark.subThoroughfare ?? "") \(placemark.thoroughfare ?? "")
                    \(placemark.locality ?? "") \(placemark.administrativeArea ?? "") \(placemark.postalCode ?? "")
                    """
        } else {
            addressLabel.text = "No Address Found"
        }
        
        dateLabel.text = format(date: date)
    }
    
    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        if segue.identifier == "pickCategory" {
            let controller = segue.destination as!
                CategoryPickerTableViewController
            controller.selectedCategoryName = categoryName
        }
    }
    
    // MARK:- Actions
    @IBAction func done() {
        // TODO: - Create object
        let location: Location
        if let temp = locationToEdit {
            location = temp
        } else {
            location = Location(context: managedObjectContext)
        }
        // TODO: - Set properties to object
        location.descriptionText = descriptionText ?? ""
        location.category = categoryName
        location.latitude = coordinate.latitude
        location.longitude = coordinate.longitude
        location.date = date
        location.placemark = placemark
        
        // TODO: - Add logic for saving in CoreData
        do {
            try managedObjectContext.save()
            self.navigationController?.popViewController(animated: true)
        } catch {
            fatalError("Error: \(error)")
        }
    }
    
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func categoryPickerDidPickCategory(
        _ segue: UIStoryboardSegue) {
        let controller = segue.source as! CategoryPickerTableViewController
        categoryName = controller.selectedCategoryName
        categoryLabel.text = categoryName
    }
    
    func format(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
