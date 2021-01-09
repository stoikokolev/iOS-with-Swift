//
//  CategoryPickerTableViewController.swift
//  My Location
//
//  Created by Veronica Velkova on 8.10.20.
//

import UIKit

class CategoryPickerTableViewController: UITableViewController {
    
    var selectedCategoryName = ""
    
    let categories = [
        "On an Adventure",
        "Dwarven City",
        "Elvish Home",
        "Forest",
        "Human village",
        "Inn",
        "Mountain",
        "Somewhere with a Generous Host",
        "The Shire"]
    
    var selectedIndexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        for i in 0..<categories.count {
            if categories[i] == selectedCategoryName {
                selectedIndexPath = IndexPath(row: i, section: 0)
                break
            }
        }
    }
    
    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue,
                             sender: Any?) {
      if segue.identifier == "pickedCategory" {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
          selectedCategoryName = categories[indexPath.row]
        }
      }
    }
    // MARK:- Table View Delegates
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath)
        
        let categoryName = categories[indexPath.row]
        cell.textLabel!.text = categoryName
        cell.textLabel!.font = UIFont(name: "RingbearerMedium", size: 16.0)
        cell.textLabel!.textColor = UIColor(named: "TextColor")
        
        if categoryName == selectedCategoryName {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != selectedIndexPath.row {
            if let newCell = tableView.cellForRow(at: indexPath) {
                newCell.accessoryType = .checkmark
            }
            if let oldCell = tableView.cellForRow(
                at: selectedIndexPath) {
                oldCell.accessoryType = .none
            }
            
            selectedIndexPath = indexPath
        }
    }
}
