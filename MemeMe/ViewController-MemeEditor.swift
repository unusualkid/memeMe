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
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        toolBar.isHidden = false
        
        return memedImage
    }
    
    func share(image: UIImage) -> Meme {
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())

        return meme
    }

    // Add the meme to the array on the AppDelegate
    func save(meme: Meme) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
    // MARK: Actions
    
    @IBAction func callActivityViewController(_ sender: Any) {
        let meme = share(image: imagePickerView.image!)
        let image = meme.memedImage
        
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)
        
        controller.completionWithItemsHandler = {(activityType, completed, returnedItems, error) in

            // if the activityType is save, don't save twice, just display the savedMessage
            if activityType != UIActivityType.saveToCameraRoll && completed {
                UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
            }
            self.save(meme: meme)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
