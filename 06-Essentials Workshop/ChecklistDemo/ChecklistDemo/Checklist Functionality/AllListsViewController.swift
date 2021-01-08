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
        
        loadChecklists()
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

// MARK: - Save-Load / Encode-Decode

extension AllListsViewController {
    func documentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentDirectory().appendingPathComponent("ChecklistDemo.plist")
    }
    
    func saveChecklist() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(allLists)
            try data.write(to: dataFilePath(),options: .atomic)
        } catch {
            print("Error encoding lists array: \(error.localizedDescription)")
        }
    }
    
    func loadChecklists() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                allLists = try decoder.decode([Checklist].self, from: data)
            } catch {
                print("Error decoding lists array: \(error.localizedDescription)")
            }
        }
    }
}
