//
//  HomeVC.swift
//  mobileAssignment
//
//  Created by Fabrice Froehly on 27/12/2017.
//  Copyright © 2017 Fabrice Froehly. All rights reserved.
//

import Foundation
import UIKit
import Presentr

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
}

class HomeVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var sendMessageTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Variables
    var user: User!
    var channels: ChannelList?
//    var messages: [Message]?
    
    // Presenter PopUpBergerMenu
    fileprivate let burgerMenu: Presentr = {
        let width = ModalSize.fluid(percentage: 0.75)
        let height = ModalSize.full
        let center = ModalCenterPosition.customOrigin(origin: CGPoint(x: 0, y: 0))
        let customType = PresentationType.custom(width: width, height: height, center: center)
        
        let customPresenter = Presentr(presentationType: customType)
        customPresenter.transitionType = .coverHorizontalFromLeft
        customPresenter.dismissTransitionType = .coverHorizontalFromLeft
        customPresenter.roundCorners = false
        customPresenter.backgroundOpacity = 0.5
        customPresenter.dismissOnSwipe = true
        return customPresenter
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.hideKeyboardWhenTappedAround()
        self.initContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        APIController.shared.listChannel(completionHandler: getListChannelCompletionHandler)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    
    
    
    
    /*****************************************************************************/
    // MARK: - KeyBoard & ScrollView
    
    @objc func keyboardWillShow(notification:NSNotification){
        
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    
    
    
    
    /*****************************************************************************/
    // MARK: - Initialize content
    
    func initContent() {
        
        // Remove 1px of border of the navigation bar
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        
        tableView.tableFooterView = UIView()
        
        self.sendMessageTextField.initTextField(placeholder: "Send message here")
    }
    
    
    
    
    
    /*****************************************************************************/
    // MARK: - Completion Handler
    
    /// Get all channel
    ///
    /// - Parameter channels: Channel list returned
    func getListChannelCompletionHandler(channels: ChannelList?) {
        
        if let channels = channels {
            
            self.channels = channels
        }
    }
    
    
    
    
    
    /*****************************************************************************/
    // MARK: - BurgerMenu
    
    @IBAction func BurgerMenuTapped(_ sender: Any) {
        
        // Instantiate viewController using storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let burgerMenuVC = storyboard.instantiateViewController(withIdentifier: "BurgerMenu") as! BurgerMenuVC
        
        // Assign variables
        burgerMenuVC.burgerMenuDelegate = self
        burgerMenuVC.user = self.user
        burgerMenuVC.channels = self.channels
        
        // Display burgerMenu
        self.customPresentViewController(self.burgerMenu, viewController: burgerMenuVC as UIViewController, animated: true, completion: nil)
    }
    
    @IBAction func sendMessageButtonTUI(_ sender: Any) {
        
        if self.sendMessageTextField.isValidMessage() {
            print("Send message")
        }
    }
    
    
    
    
    
    /*****************************************************************************/
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueProfile" {
            
            let destVC = segue.destination as! ProfileVC
            
            destVC.user = self.user
        } else if segue.identifier == "segueCreateChannel" {
            
            let destVC = segue.destination as! CreateChannelVC
            
            destVC.user = self.user
        }
    }
}





extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MessageCell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! MessageCell
        
        // Fill cell with messages[indexPath.row].blabla
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
    }
}





// MARK: - Protocol of burger menu to switch controller
extension HomeVC: BurgerMenuDelegate {
    
    func changeViewController(segue: String) {
        
        performSegue(withIdentifier: segue, sender: nil)
    }
    
    func openChat(channel: Channel) {
        
        // CALL API TO GET ALL MESSAGES, REMPLIR CETTE VARIABLE ET AFFICHER CORRECTEMENT TOUT CA, PUIS FAIRE EN SORTE DE POUVOIR ENVOYER DES MESSAGES
    }
}
