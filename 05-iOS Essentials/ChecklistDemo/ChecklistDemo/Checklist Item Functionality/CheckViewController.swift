//
//  ViewController.swift
//  ChecklistDemo
//
//  Created by Stoyko Kolev on 28.12.20.
//

import UIKit

class CheckViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var checklist: Checklist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .always
        
        //generateDummyData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ItemDetailTableViewController {
            destination.delegate = self
            
            if let cell = sender as? UITableViewCell,
               let indexPath = tableView.indexPath(for: cell),
                segue.identifier == "editItem" {
                destination.itemToEdit = checklist.checklistItems[indexPath.row]
                
            }
        }
    }
    
    // MARK: - UITableView Helpers
    private func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.itemName
    }
    
    private func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        label.text = item.isChecked ? "" : "✓"
    }
}

// MARK: - UITableViewDataSource
extension CheckViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        checklist.checklistItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "checkTableViewCell", for: indexPath)
        let item = checklist.checklistItems[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CheckViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        let item = checklist.checklistItems[indexPath.row]
        item.isChecked.toggle()
        configureCheckmark(for: cell, with: item)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        checklist.checklistItems.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - ItemDetailTableViewControllerDelegate
extension CheckViewController: ItemDetailTableViewControllerDelegate {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailTableViewController, didFinishAddingItem item: ChecklistItem) {
        let newRowIndex = checklist.checklistItems.count
        checklist.checklistItems.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        navigationController?.popViewController(animated: true)
    }
    
  func itemDetailViewController(_ controller: ItemDetailTableViewController, didFinishEditing item: ChecklistItem) {
    if let index = checklist.checklistItems.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
}
