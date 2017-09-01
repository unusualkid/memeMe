//
//  ViewController-MemeSaver.swift
//  MemeMe
//
//  Created by Kenneth Chen on 8/31/17.
//  Copyright © 2017 Cotery. All rights reserved.
//

import Foundation
import UIKit


// This extension contains methods specific for picking images from the photo library or launching the camera
// MARK: - ViewController

extension ViewController {
    
    func generateMemedImage() -> UIImage {
        
        toolBar.isHidden = true
        
        UIGraphicsBeginImageContext(view.frame.size)
        
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!

        UIGraphicsEndImageContext()

        toolBar.isHidden = false

        return memedImage
    }
    
    func save(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        self.displaySavedMessage(error: error)
    }
    
    func displaySavedMessage(error: Error?) {
        if let error = error {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Saved!", message: "Image saved successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    
    // MARK: Actions
    
    @IBAction func callActivityViewController(_ sender: Any) {
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        let image = meme.memedImage
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)

        self.present(controller, animated: true, completion: nil)
        
        
        controller.completionWithItemsHandler = {(activityType, completed, returnedItems, error) in
            if !completed {
                return
            }
            
            // if the activityType is save, don't save twice, just display the savedMessage
            if activityType != UIActivityType.saveToCameraRoll {
                self.save(image: image)
            } else {
                self.displaySavedMessage(error: error)
            }
        }
    }
}
