//
//  LocationsViewController.swift
//  Bilbo's Diary
//
//  Created by Veronica Velkova on 9.10.20.
//

import UIKit
import CoreData

class LocationsViewController: UITableViewController {
    // MARK: - Properties
    // TODO: - DI for managedObjectContext
    var managedObjectContext: NSManagedObjectContext!
    // TODO: - FetchedResultsController
    lazy var fetchedResultsController: NSFetchedResultsController<Location> = {
        let fetchedRequest = NSFetchRequest<Location>()
        let entity = Location.entity()
        fetchedRequest.entity = entity
        
        let categoryDescriptor = NSSortDescriptor(key: "category", ascending: true)
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchedRequest.sortDescriptors = [categoryDescriptor, sortDescriptor]
        fetchedRequest.fetchBatchSize = 20
        
        let fetchResultsController = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: "category", cacheName: "Locations")
        fetchResultsController.delegate = self
        
        return fetchResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: - Prepare controller's data
        performFetch()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editLocation" {
            let destination = segue.destination as! LocationDetailsTableViewController
            // TODO: - Prepare next controller
            destination.managedObjectContext = managedObjectContext
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                let location = fetchedResultsController.object(at: indexPath)
                destination.locationToEdit = location
            }
        }
    }
    
    // MARK:- Helper methods
    func performFetch() {
        // TODO: - Fetch objects from CoreData
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError()
        }
    }
}

extension LocationsViewController {
    override func tableView(_ tableView: UITableView,
                            viewForHeaderInSection section: Int) -> UIView? {
        // we create label here programatically
        let labelRect = CGRect(x: 15,
                               y: tableView.sectionHeaderHeight - 22,
                               width: 300, height: 22)
        let label = UILabel(frame: labelRect)
        
        label.text = tableView.dataSource!.tableView!(
            tableView, titleForHeaderInSection: section)
        
        label.textColor = UIColor(named: "Color")
        label.font = UIFont(name: "RingbearerMedium", size: 20.0)
        label.backgroundColor = UIColor.clear
        
        // we create the line separator
        let separatorRect = CGRect(x: 15, y: tableView.sectionHeaderHeight - 0.5,
                                   width: tableView.bounds.size.width - 12, height: 0.5)
        let separator = UIView(frame: separatorRect)
        separator.backgroundColor = tableView.separatorColor
        
        let viewRect = CGRect(x: 0, y: 0,
                              width: tableView.bounds.size.width,
                              height: tableView.sectionHeaderHeight)
        // we create vustom view
        let view = UIView(frame: viewRect)
        view.addSubview(label)
        view.addSubview(separator)
        // and return it as tableView header
        return view
    }
    
    
    override func numberOfSections(in tableView: UITableView)
    -> Int {
        // TODO: - Return number of sections
        return fetchedResultsController.sections!.count
    }
    
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        // TODO: - Return title of the section
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: - Return number of rows per section
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationTableViewCell
        // TODO: - Configure cell with location
        let location = fetchedResultsController.object(at: indexPath)
        cell.configure(location)
        
        return cell
    }
}

extension LocationsViewController {
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // TODO: - Delete from CoreData
            let location = fetchedResultsController.object(at: indexPath)
            managedObjectContext.delete(location)
            
            do {
                try managedObjectContext.save()
            } catch {
                fatalError()
            }
            
        }
    }
}

extension LocationsViewController: NSFetchedResultsControllerDelegate {
    //TODO: - Copy-Paste Generic Code comes here
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("*** controllerWillChangeContent")
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            print("*** NSFetchedResultsChangeInsert (object)")
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            print("*** NSFetchedResultsChangeDelete (object)")
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            print("*** NSFetchedResultsChangeUpdate (object)")
            if let cell = tableView.cellForRow(at: indexPath!) as? LocationTableViewCell {
                let location = controller.object(at: indexPath!) as! Location
                cell.configure(location)
            }
        case .move:
            print("*** NSFetchedResultsChangeMove (object)")
            tableView.deleteRows(at: [indexPath!], with: .fade)
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        @unknown default:
            fatalError("Unhandled switch case of NSFetchedResultsChangeType")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("*** controllerDidChangeContent")
        tableView.endUpdates()
    }
}
