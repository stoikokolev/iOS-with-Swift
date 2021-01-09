//
//  ViewController.swift
//  Checklist
//
//  Created by Stoyko Kolev on 18.09.20.
//

import UIKit

class CheckViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var todoItemsTableView: UITableView!
    
    // MARK: - UIViewController Properties
    var checklist: Checklist!
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        title = checklist.name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ItemDetailViewController, segue.identifier == "showAddItem" {
            destination.delegate = self
        } else if let destination = segue.destination as? ItemDetailViewController,
                  let cell = sender as? UITableViewCell,
                  segue.identifier == "showEditItem" {
            destination.delegate = self
            if let indexPath = todoItemsTableView.indexPath(for: cell) {
                destination.itemToEdit = checklist.checklistItems[indexPath.row]
            }
            
        }
    }
    
    // MARK: - Private Methods
    private func configureCheckmark(for cell: ToDoItemTableViewCell, with item: ChecklistItem) {
        cell.checkMarkLabel.text = item.isChecked ? "" : "✓"
        
    }
    
    private func configureText(for cell: ToDoItemTableViewCell, with item: ChecklistItem) {
        cell.itemNameLabel.text = item.itemName
    }
}

// MARK: - UITableView DataSource
extension CheckViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        checklist.checklistItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoItemTableViewCell.reuseIdentifier, for: indexPath) as! ToDoItemTableViewCell
        
        let item = checklist.checklistItems[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
}

// MARK: - UITableView Delegate
extension CheckViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ToDoItemTableViewCell else {
            return
        }
        
        let item = checklist.checklistItems[indexPath.row]
        item.modifyIsChecked()
        
        configureCheckmark(for: cell, with: item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        checklist.checklistItems.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - AddItemTableViewControllerDelegate
extension CheckViewController: ItemDetailViewControllerDelegate {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        let newRowIndex = checklist.checklistItems.count
        checklist.checklistItems.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        todoItemsTableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        if let index = checklist.checklistItems.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = todoItemsTableView.cellForRow(at: indexPath) as? ToDoItemTableViewCell {
              configureText(for: cell, with: item)
            }
          }
        navigationController?.popViewController(animated: true)
    }
    
    
}

