//
//  MenuItemDetailViewController.swift
//  GuidedProject_OrderApp
//
//  Created by Tomonao Hashiguchi on 2022-05-19.
//

import UIKit

@MainActor
class MenuItemDetailViewController: UIViewController {
    
    let menuItem: MenuItem
    
    init?(coder: NSCoder, menuItem: MenuItem){
        self.menuItem = menuItem
        super.init(coder: coder)
    }
    required init?(coder:NSCoder){
        fatalError("init(coder:) has not beeen implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
