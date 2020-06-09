//
//  WelcomeViewController.swift
//  FirebaseChat
//
//  Created by patelpra on 6/7/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//


import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBAction func getChatting(_ sender: Any) {
        
        guard let text = usernameTextField.text, text != "" else {
            presentInformationAlertController(title: "Error:", message: "Please enter a username into the field")
            return
        }
    }
}

extension UIViewController {
    func presentInformationAlertController(title: String?, message: String?, dismissActionCompletion: ((UIAlertAction) -> Void)? = nil,
                                           completion: (()-> Void)? = nil) {
        let  alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: dismissActionCompletion)
        
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true, completion: completion)
    }
}

