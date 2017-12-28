//
//  EXTextField.swift
//  mobileAssignment
//
//  Created by Fabrice Froehly on 27/12/2017.
//  Copyright © 2017 Fabrice Froehly. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    /*****************************************************************************/
    // MARK: - Graphical functions
    
    // Initialize the textTield with different attributes
    func initTextField(placeholder: String) {
        
        self.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        self.setNormalBorderColor()
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                               attributes: [NSAttributedStringKey.foregroundColor: Colors.validTextFieldTextColor])
    }
    
    func setNormalBorderColor() {
        
        self.layer.borderColor = Colors.validTextFieldBorderColor.cgColor
    }
    
    func setErrorBorderColor() {
        
        self.layer.borderColor = Colors.errorTextFieldBorderColor.cgColor
    }
    
    
    
    
    
    
    /*****************************************************************************/
    // MARK: - Check if textfield is valid
    
    func isValidText() -> Bool {
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
        
        let textRegex = "[A-Za-z]{5,20}"
        let result = NSPredicate(format: "SELF MATCHES %@", textRegex).evaluate(with: self.text!)
        if !result {
            self.setErrorBorderColor()
            return result
        }
        self.setNormalBorderColor()
        return result
    }
    
    func isValidMessage() -> Bool {
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
        
        let textRegex = "[A-Za-z0-9 áàâäãåçéèêëíìîïñóòôöõúùûüýÿæœÁÀÂÄÃÅÇÉÈÊËÍÌÎÏÑÓÒÔÖÕÚÙÛÜÝŸÆŒ._-]{0,50}"
        let result = NSPredicate(format: "SELF MATCHES %@", textRegex).evaluate(with: self.text!)
        if !result {
            self.setErrorBorderColor()
            return result
        }
        self.setNormalBorderColor()
        return result
    }
}
