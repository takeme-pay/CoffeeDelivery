//
//  ViewController.swift
//  CoffeeDelivery
//
//  Created by Tyler Wells on 2019/04/24.
//  Copyright © 2019 Tyler Wells. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var isInProgress: Bool = false
    
    @IBAction func payButtonAction(_ sender: UIButton) {
        
    }
    
    fileprivate func getDisplayStringsFor(_ state: TMPPaymentRequestState) -> (String, String) {
        switch state {
        case .success:
            return ("Payment succeeded", "You got a coffee :)")
        case .failure:
            return ("Payment failed", "Payment failed with specific payment method, please check the logs")
        case .canceled:
            return ("Payment canceled", "You canceled the payment")
        default:
            return ("","")
        }
    }
}

