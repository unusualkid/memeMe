//
//  ViewController-ImagePicker.swift
//  MemeMe
//
//  Created by Kenneth Chen on 8/27/17.
//  Copyright © 2017 Cotery. All rights reserved.
//

import Foundation
import UIKit


// This extension contains methods specific for picking images from the photo library or launching the camera
// MARK: - ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image

            actionButton.isEnabled = true
            cancelButton.isEnabled = true
            self.dismiss(animated: true, completion: nil)
            imagePickerView.frame.size = imagePickerView.image!.size
        }
    }
    
    // MARK: Actions

    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
}
