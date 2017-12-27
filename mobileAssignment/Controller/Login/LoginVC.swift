//
//  LoginVC.swift
//  mobileAssignment
//
//  Created by Fabrice Froehly on 27/12/2017.
//  Copyright © 2017 Fabrice Froehly. All rights reserved.
//

import Foundation
import UIKit

class LoginVC: UIViewController {
    
    // Variables
    var user: User!
    
    // Outlets
    @IBOutlet weak var nicknameTextField: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init content of the view
        self.initContent()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    
    
    
    
    /*****************************************************************************/
    // MARK: - Init content
    
    func initContent() {
        
        // Init content of textfield
        self.nicknameTextField.initTextField(placeholder: "Login")
    }
    
    
    
    
    
    /*****************************************************************************/
    // MARK: - IBAction
    
    @IBAction func loginButtonTUI(_ sender: Any) {
        
        if self.nicknameTextField.isValidText() {
            
            // Try to login/create user to connect to the app
            APIController.shared.getUser(nickname: self.nicknameTextField.text!, completionHandler: getUserCompletionHandler)
        } else {
            
            self.presentAlert(title: "Login error", message: "You used unauthorized characters in your nickname")
        }
    }
    
    
    
    
    
    /*****************************************************************************/
    // MARK: - Alert
    
    func presentAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)

        alert.addAction(UIAlertAction(title: "Understood", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    

    /*****************************************************************************/
    // MARK: - Completion handler
    
    /// Completion called when the get user had succeeded
    ///
    /// - Parameter user: The user returned
    func getUserCompletionHandler(user: User?) {
        
        if let user = user {
            
            self.performSegue(withIdentifier: "segueHome", sender: nil)
            self.user = user
        } else {
            
            APIController.shared.createUser(nickname: self.nicknameTextField.text!, completionHandler: createUserCompletionHandler)
        }
    }
    
    /// Completion called when the get user had succeeded
    ///
    /// - Parameter user: The user returned
    func createUserCompletionHandler(user: User?) {
        
        if let user = user {
            
            self.user = user
            self.performSegue(withIdentifier: "segueHome", sender: nil)
        } else {
            
            self.presentAlert(title: "Login error", message: "Impossible to connect, please check your internet connection and try again. If the problem persists, contact an administrator")
        }
    }
    
    
    
    
    
    /*****************************************************************************/
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueHome" {
            
            let destVC = segue.destination as! HomeVC
            
            destVC.user = self.user
        }
    }
}
