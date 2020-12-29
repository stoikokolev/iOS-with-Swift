//
//  AddItemTableViewController.swift
//  ChecklistDemo
//
//  Created by Veronica Velkova on 28.09.20.
//

import UIKit

protocol AddItemTableViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailTableViewController)
    func itemDetailViewController(_ controller: ItemDetailTableViewController, didFinishAddingItem item: ChecklistItem)
}

class ItemDetailTableViewController: UITableViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    // MARK: - Properties
    weak var delegate: AddItemTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - IBAction
    @IBAction func cancel() {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
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
