//
//  MenuItemDetailViewController.swift
//  GuidedProject_OrderApp
//
//  Created by Tomonao Hashiguchi on 2022-05-19.
//

import UIKit

@MainActor
class MenuItemDetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var detailTetLabel: UILabel!
    @IBOutlet var addToOrderButton: UIButton!
    
    
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

        updateUI()
    }
    
    func updateUI(){
        nameLabel.text = menuItem.name
        priceLabel.text = menuItem.price.formatted(.currency(code: "usd"))
        detailTetLabel.text = menuItem.detailText
    }
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [], animations: {
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
        MenuController.shared.order.menuItems.append(menuItem)
    }
}
