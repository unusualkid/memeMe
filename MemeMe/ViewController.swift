//
//  ViewController.swift
//  MemeMe
//
//  Created by Kenneth Chen on 8/24/17.
//  Copyright © 2017 Cotery. All rights reserved.
//

import UIKit

// MARK: - ViewController: UIViewController

class ViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!

    
    
    // MARK: Properties
    
    let topTextFieldDelegate = CaptionTextFieldDelegate()
    let bottomTextFieldDelegate = CaptionTextFieldDelegate()
    
    var memedImage: UIImage!
    
    var barsAreHidden = false
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0]

    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tap(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        cancelButton.isEnabled = false
        actionButton.isEnabled = false
        topText.text = "TOP"
        configureUI(topText)
        topTextFieldDelegate.cancelButton = cancelButton
        bottomText.text = "BOTTOM"
        configureUI(bottomText)
        bottomTextFieldDelegate.cancelButton = cancelButton
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: Helper Functions
    
    func configureUI(_ textField: UITextField) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
        
        if textField.text == "TOP" {
            textField.delegate = topTextFieldDelegate
            topTextFieldDelegate.cancelButton = cancelButton
        } else {
            textField.delegate = bottomTextFieldDelegate
            bottomTextFieldDelegate.cancelButton = cancelButton
        }
    }
    
    // Dismiss the keyboard when tapping outside the top and bottom textfields
    func tap(gesture: UITapGestureRecognizer) {
        topText.resignFirstResponder()
        bottomText.resignFirstResponder()
    }
    
    // MARK: Actions
    
    @IBAction func cancelPickedImage(_ sender: Any) {
        imagePickerView.image = nil
        cancelButton.isEnabled = false
        actionButton.isEnabled = false
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        topTextFieldDelegate.isDefaultText = true
        bottomTextFieldDelegate.isDefaultText = true
    }
}

