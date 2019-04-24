//
//  ViewController.swift
//  CoffeeDelivery
//
//  Created by Tyler Wells on 2019/04/24.
//  Copyright © 2019 Japan Foodie. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TMPPaymentDelegate {

    var isInProgress: Bool = false
    
    @IBAction func payButtonAction(_ sender: UIButton) {
        // 1. init a source params with necessary information.
        // 2. create TMPPayment from sourceParams, ephemerKeyProvider and delegate.
        guard !isInProgress,
            let params = TMPSourceParams(description: "Coffee Delivery Service", amount: 10, currency: "JPY"),
            let payment = TMPPayment(sourceParams: params, delegate: self) else {
                return
        }
        
        self.isInProgress = true
        
        // 3. start payment action. ( with optional tapic engine impact )
        payment.startAction(["useTapticEngine": true])
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
    
    func payment(_ payment: TMPPayment, didFinishWith state: TMPPaymentRequestState, userInfo: [AnyHashable : Any]? = nil) {
        self.isInProgress = false
        
        // Get our alert messages for displaying
        let alertTitle = self.getDisplayStringsFor(state).0
        let alertMessage = self.getDisplayStringsFor(state).1
        
        // Instantiate our alert and display it
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alertController, animated: true)
    }
}
