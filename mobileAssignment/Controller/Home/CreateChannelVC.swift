//
//  CreateChannelVC.swift
//  mobileAssignment
//
//  Created by Fabrice Froehly on 28/12/2017.
//  Copyright © 2017 Fabrice Froehly. All rights reserved.
//

import Foundation
import UIKit

class CreateChannelVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var channelNameTextField: UITextField!
    
    // Variables
    var user: User!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initContent()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    
    
   
    
    /*****************************************************************************/
    // MARK: - Init content
    
    func initContent() {
        
        // Remove 1px of border of the navigation bar
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        
        // Init content of textfield
        self.channelNameTextField.initTextField(placeholder: "Channel Name")
    }
    
    
    
    
    
    /*****************************************************************************/
    // MARK: - IBAction
    
    @IBAction func CancelTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelButtonTUI(_ sender: Any) {
        
        if self.channelNameTextField.isValidText() {
            
            // Try to login/create user to connect to the app
            APIController.shared.openChannel(channelName: channelNameTextField.text!, completionHandler: createChannelCompletionHandler)
        } else {
            
            self.presentAlert(title: "Create channel error", message: "You used unauthorized characters in your channel Name")
        }
    }
    
    
    
    
    
    /*****************************************************************************/
    // MARK: - Completion Handler
    
    func createChannelCompletionHandler(channel: Channel?) {
        
        if channel != nil && channel?.channel_url != nil {
            
            dismiss(animated: true, completion: nil)
        } else {
            
            self.presentAlert(title: "Create channel error", message: "You weren't able to create this channel")
        }
    }
    
    
    
    
    
    /*****************************************************************************/
    // MARK: - Alert
    
    func presentAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Understood", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
