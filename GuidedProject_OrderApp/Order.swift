//
//  Order.swift
//  GuidedProject_OrderApp
//
//  Created by Tomonao Hashiguchi on 2022-05-19.
//

import Foundation

struct Order: Codable{
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []){
        self.menuItems = menuItems
    }
}
