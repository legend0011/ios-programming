//
//  ItemStore.swift
//  LootLogger
//
//  Created by jack zhang on 2022/8/14.
//

import UIKit

class ItemStore {

    var allItems = [Item]()
    
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)

        allItems.append(newItem)

        return newItem
    }

}


