//
//  editItemViewControllerTableViewController.swift
//  tableView
//
//  Created by Sodhi, Jaswinder on 7/23/19.
//  Copyright © 2019 Sodhi, Jaswinder. All rights reserved.
//

import UIKit

protocol EditItemViewControllerDelegate: class {

    func editItemViewController(_ controller: EditItemViewController, didFinishedAddingItem item: ChecklistItem)
    func editItemViewControllerDidCancel(_ controller: EditItemViewController)
    func editItemViewController(_ controller: EditItemViewController, didFinishEditingItem item: ChecklistItem)
}

class EditItemViewController: UITableViewController {
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!

    weak var delegate: EditItemViewControllerDelegate?
    weak var itemToEdit: ChecklistItem?
    weak var itemStore: ItemStore?
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        navigationItem.largeTitleDisplayMode = .never
        if let item = itemToEdit{
            navigationItem.title = "Edit Item"
            doneButton.isEnabled = true
            textField.text = item.name
        }
    }

    @IBAction func done(_ sender: Any) {
        if let item = itemToEdit, let text = textField.text  {
            item.name = text
            delegate?.editItemViewController(self, didFinishEditingItem: item)
        } else {
            if let item = itemStore?.addItem() {
                item.checked = false
                if let text = textField.text {
                    item.name = text
                }
                delegate?.editItemViewController(self, didFinishedAddingItem: item)
            }
        }
    }

    @IBAction func cancel(_ sender: Any) {
        delegate?.editItemViewControllerDidCancel(self)
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
}

extension EditItemViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text,
            let stringRange = Range(range, in: oldText) else {
                return false
        }
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            doneButton.isEnabled = false
        } else {
            doneButton.isEnabled = true
        }
        return true
    }

}
