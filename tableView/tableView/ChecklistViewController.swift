//
//  ViewController.swift
//  tableView
//
//  Created by Sodhi, Jaswinder on 7/22/19.
//  Copyright © 2019 Sodhi, Jaswinder. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    var itemStore: ItemStore

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    required init?(coder aDecoder: NSCoder) {
        itemStore = ItemStore()
        super.init(coder: aDecoder)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = itemStore.checklistItems[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.checklistItems.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            configureCheckmark(for: cell, with: itemStore.checklistItems[indexPath.row])
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        if let label = cell.viewWithTag(19) as? UILabel {
            label.text = item.name
        }
    }

    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        if let label = cell.viewWithTag(777) as? UILabel {
            if  item.checked {
                label.text = "√"
            } else {
                label.text = ""
            }
        }
        item.toggleChecked()
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        itemStore.checklistItems.remove(at: index)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

//    @IBAction func addItem(_ sender: UIBarButtonItem) {
//        let newRowIndex = itemStore.checklistItems.count
//        _  = itemStore.addItem()
//        let indexPath = IndexPath(row: newRowIndex, section: 0)
//        tableView.insertRows(at: [indexPath], with: .left)
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let editItemViewController = segue.destination as? EditItemViewController {
                editItemViewController.delegate = self
                editItemViewController.itemStore = itemStore
            }
        } else if segue.identifier == "EditItemSegue" {
            if let vc = segue.destination as? EditItemViewController, let cell = sender as? UITableViewCell {
                if let rowIndex = tableView.indexPath(for: cell)?.row {
                    vc.itemToEdit = itemStore.checklistItems[rowIndex]
                    vc.delegate = self
                }
            }
        }
    }

}

extension ChecklistViewController: EditItemViewControllerDelegate {

    func editItemViewController(_ controller: EditItemViewController, didFinishedAddingItem item: ChecklistItem) {
        navigationController?.popViewController(animated: true)
        let rowIndex = itemStore.checklistItems.count - 1 
        let indexPath = IndexPath(row: rowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    func editItemViewControllerDidCancel(_ controller: EditItemViewController) {
        navigationController?.popViewController(animated: true)
    }

    func editItemViewController(_ controller: EditItemViewController, didFinishEditingItem item: ChecklistItem) {
        guard let index = itemStore.checklistItems.firstIndex(of: item) else {
            return
        }
        itemStore.checklistItems[index] = item
        let indexPath = IndexPath(row: index, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) {
            configureText(for: cell, with: item)
        }
        navigationController?.popViewController(animated: true)
    }
}
