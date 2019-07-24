//
//  todoList.swift
//  tableView
//
//  Created by Sodhi, Jaswinder on 7/22/19.
//  Copyright © 2019 Sodhi, Jaswinder. All rights reserved.
//

import Foundation

class ItemStore {
    var checklistItems = [ChecklistItem]()

    init() {
        for _ in 1...5 {
            checklistItems.append(ChecklistItem())
        }
        checklistItems[0].name = "Take a jog"
        checklistItems[1].name = "Watch a movie"
        checklistItems[2].name = "Code an app"
        checklistItems[3].name = "Walk the dog"
        checklistItems[4].name = "Study design patterns"
    }

    func addItem() -> ChecklistItem {
        var item = ChecklistItem()
        item.name = randomTitle()
        item.checked = true
        checklistItems.append(item)
        return item
    }

    private func randomTitle() -> String {
        var titles = ["New todo item", "Generic todo", "gym", "Go to DC","Eat,pray,love"]
        return titles[Int.random(in: 0..<titles.count)]
    }
}
