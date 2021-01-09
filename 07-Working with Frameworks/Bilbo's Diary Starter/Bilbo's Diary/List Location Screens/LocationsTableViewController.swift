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
    
    // TODO: - FetchedResusltsController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: - Prepare controller's data
        performFetch()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editLocation" {
            let destination = segue.destination as! LocationDetailsTableViewController
            // TODO: - Prepare next controller
        }
    }
    
    // MARK:- Helper methods
    func performFetch() {
        // TODO: - Fetch objects from CoreData

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
        1
    }
    
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        // TODO: - Return title of the section
        ""
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: - Return number of rows per section
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationTableViewCell
        // TODO: - Configure cell with location
        return cell
    }
    
    
}

extension LocationsViewController {
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // TODO: - Delete from CoreData
        }
    }
}

extension LocationsViewController: NSFetchedResultsControllerDelegate {
    //TODO: - Copy-Paste Generic Code comes here
    
}
