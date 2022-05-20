//
//  OrderTableViewController.swift
//  GuidedProject_OrderApp
//
//  Created by Tomonao Hashiguchi on 2022-05-19.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    var minutesToPrepareOrder = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
        
        NotificationCenter.default.addObserver(tableView!, selector: #selector(UITableView.reloadData), name: MenuController.orderUpdateNotification, object: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MenuController.shared.order.menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Order", for: indexPath)
        
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    func configure(_ cell:UITableViewCell, forItemAt indexPath: IndexPath){
        let menuItem = MenuController.shared.order.menuItems[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = menuItem.name
        content.secondaryText = menuItem.price.formatted(.currency(code: "usd"))
        cell.contentConfiguration = content
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            MenuController.shared.order.menuItems.remove(at: indexPath.row)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    @IBAction func submitTapped(_ sender: UIBarButtonItem) {
        let orderTotal = MenuController.shared.order.menuItems.reduce(0.0) {(result, menuItem) -> Double in
            return result + menuItem.price
        }
        
        let formattedTotal = orderTotal.formatted(.currency(code: "usd"))
        let alertController = UIAlertController(title: "Cofirm Order", message: "You are about to submit your order with a total of \(formattedTotal)", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Submit", style: .default, handler: {_ in
            self.uploadOrder()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func uploadOrder(){
        let menuIDs = MenuController.shared.order.menuItems.map { $0.id }
        Task.init{
            do{
                let minutesToPrepare = try await MenuController.shared.submitOrder(forMenuIDs: menuIDs)
                minutesToPrepareOrder = minutesToPrepare
                performSegue(withIdentifier: "comfirmOrder", sender: nil)
            }catch{
                displayError(error, title: "Order Submission Failed")
            }
        }
    }
    func displayError(_ error: Error, title: String){
        guard let _ = viewIfLoaded?.window else {return}
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBSegueAction func confirmOrder(_ coder: NSCoder) -> OrderConfirmationViewController? {
        return OrderConfirmationViewController(coder: coder, minutesToPrepare: minutesToPrepareOrder)
    }
    
    @IBAction func unwindToOrderList(segue: UIStoryboardSegue){
        
    }
}
