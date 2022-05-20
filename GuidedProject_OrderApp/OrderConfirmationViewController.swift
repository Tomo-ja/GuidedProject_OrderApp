//
//  OrderConfirmationViewController.swift
//  GuidedProject_OrderApp
//
//  Created by Tomonao Hashiguchi on 2022-05-19.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    
    @IBOutlet var confirmationLabel: UILabel!
    
    var minutesToPrepare: Int
    
    init?(coder: NSCoder, minutesToPrepare: Int){
        self.minutesToPrepare = minutesToPrepare
        super.init(coder: coder)
    }
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        confirmationLabel.text = "Thank you for your order! Your wait time is approximately \(minutesToPrepare) minutes."
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
