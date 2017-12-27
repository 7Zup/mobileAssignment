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

class HomeVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    // Variables
    var user: User!
    
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
        
        self.initContent()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    
    
    
    
    /*****************************************************************************/
    // MARK: - Initialize content
    
    func initContent() {
        
        // Remove 1px of border of the navigation bar
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
    }
    
    
    
    
    
    /*****************************************************************************/
    // MARK: - BurgerMenu
    
    @IBAction func BurgerMenuTapped(_ sender: Any) {
        
        // Instantiate viewController using storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let burgerMenuVC = storyboard.instantiateViewController(withIdentifier: "BurgerMenu") as! BurgerMenuVC
        
        burgerMenuVC.user = self.user
        
        // Display burgerMenu
        self.customPresentViewController(self.burgerMenu, viewController: burgerMenuVC as UIViewController, animated: true, completion: nil)
    }
    
    /*****************************************************************************/
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueProfile" {
            
            let destVC = segue.destination as! ProfileVC
            
            destVC.user = self.user
        }
    }
}
