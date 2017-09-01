//
//  CaptionDelegate.swift
//  MemeMe
//
//  Created by Kenneth Chen on 8/26/17.
//  Copyright © 2017 Cotery. All rights reserved.
//

import Foundation
import UIKit

// MARK: - CashTextFieldDelegate: NSObject, UITextFieldDelegate

class CaptionTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var isDefaultText = true
    var cancelButton = UIBarButtonItem()
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if isDefaultText {
            textField.text = ""
            isDefaultText = false
            cancelButton.isEnabled = true
        }
        textField.autocapitalizationType = UITextAutocapitalizationType.allCharacters
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

