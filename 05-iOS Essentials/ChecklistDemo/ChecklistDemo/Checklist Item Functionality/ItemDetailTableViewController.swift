//
//  AddItemTableViewController.swift
//  ChecklistDemo
//
//  Created by Stoyko Kolev on 28.12.20.
//

import UIKit

protocol ItemDetailTableViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailTableViewController)
    func itemDetailViewController(_ controller: ItemDetailTableViewController, didFinishAddingItem item: ChecklistItem)
    func itemDetailViewController(_ controller: ItemDetailTableViewController, didFinishEditing item: ChecklistItem)
}

class ItemDetailTableViewController: UITableViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    // MARK: - Properties
    weak var delegate: ItemDetailTableViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit {
            title = "Edit item"
            textField.text = item.itemName
            doneButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textField.becomeFirstResponder()
    }
    
    // MARK: - IBAction
    @IBAction func cancel() {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let item = itemToEdit {
            item.itemName = textField.text!
            delegate?.itemDetailViewController(self, didFinishEditing: item)
            
            return
        }
        
        let checklistItem = ChecklistItem(textField.text!, isChecked: false)
        delegate?.itemDetailViewController(self, didFinishAddingItem: checklistItem)
    }
}

extension ItemDetailTableViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        doneButton.isEnabled = !newText.isEmpty
        return true
    }
}
