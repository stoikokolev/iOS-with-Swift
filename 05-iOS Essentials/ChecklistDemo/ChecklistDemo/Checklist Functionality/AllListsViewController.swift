//
//  ChecklistViewController.swift
//  ChecklistDemo
//
//  Created by Stoyko Kolev on 28.12.20.
//

import UIKit

class AllListsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var allLists: [Checklist] = []
    let cellIdentifier = "ChecklistCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        generateDummyData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CheckViewController,
           segue.identifier == "showItems" {
            destination.checklist = (sender as! Checklist)
        }
    }
    
    // MARK: - Helper
    private func generateDummyData() {
        allLists.append(Checklist("Have a coffee"))
        allLists.append(Checklist("Brush my teeth"))
        allLists.append(Checklist("Walk the dog"))
        allLists.append(Checklist("Have a standup"))
        allLists.append(Checklist("Code some apps"))
    }
}

extension AllListsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if let recycledCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            cell = recycledCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        cell.textLabel?.text = allLists[indexPath.row].name
        cell.detailTextLabel?.text = "\(allLists[indexPath.row].countUncheckedItems()) Remaining"
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
}

extension AllListsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checklist = allLists[indexPath.row]
        performSegue(withIdentifier: "showItems", sender: checklist)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(identifier: "ListDetailTableViewController") as! ListDetailTableViewController
        
        // TODO: - Implement me
        
        navigationController?.pushViewController(controller, animated: true)
    }
}
