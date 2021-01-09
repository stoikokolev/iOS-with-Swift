//
//  AllListsViewController.swift
//  Checklist
//
//  Created by Stoyko Kolev on 23.09.20.
//

import UIKit

class AllListsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!/* {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        }
    }*/
    
    // MARK: - Properties
    var dataModel: DataModel!
    private let cellIdentifier = "ChecklistCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.delegate = self
        
        let index = dataModel.indexOfSelectedChecklist
        if index >= 0 && index < dataModel.checklists.count {
            let checklist = dataModel.checklists[index]
            performSegue(withIdentifier: "showChecklist",
                         sender: checklist)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChecklist",
           let destination = segue.destination as? CheckViewController,
           let sender = sender as? Checklist{
            destination.checklist = sender
        } else if let destination = segue.destination as? ListDetailTableViewController {
            if segue.identifier == "showEditChecklist" {
                destination.checklistToEdit = sender as? Checklist
            }
            
            destination.delegate = self
        }
    }
    
}

extension AllListsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataModel.checklists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if let recycledCell =
            tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            cell = recycledCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        cell.textLabel?.text = dataModel.checklists[indexPath.row].name
        cell.detailTextLabel?.text = "\(dataModel.checklists[indexPath.row].countUncheckedItems()) Remaining"
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    
}

extension AllListsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checklist = dataModel.checklists[indexPath.row]
        dataModel.indexOfSelectedChecklist = indexPath.row
        //UserDefaults.standard.set(indexPath.row,
        //                           forKey: "ChecklistIndex")
        performSegue(withIdentifier: "showChecklist", sender: checklist)
    }
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath) {
        dataModel.checklists.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    func tableView(_ tableView: UITableView,
                   accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        let controller = storyboard!.instantiateViewController(
            withIdentifier: "ListDetailViewController")
            as! ListDetailTableViewController
        controller.delegate = self
        
        let checklist = dataModel.checklists[indexPath.row]
        controller.checklistToEdit = checklist
        
        navigationController?.pushViewController(controller,
                                                 animated: true)
    }
}

extension AllListsViewController: ListDetailViewControllerDelegate {
    func listDetailViewControllerDidCancel(_ controller: ListDetailTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailTableViewController, didFinishAdding checklist: Checklist) {
        let newRowIndex = dataModel.checklists.count
        dataModel.checklists.append(checklist)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailTableViewController, didFinishEditing checklist: Checklist) {
        if let index = dataModel.checklists.firstIndex(of: checklist) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = checklist.name
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UINavigationControllerDelegate
extension AllListsViewController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool) {
        
        if viewController === self {
            dataModel.indexOfSelectedChecklist = -1
            //UserDefaults.standard.set(-1, forKey: "ChecklistIndex")
        }
    }
}

