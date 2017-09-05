//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Kenneth Chen on 9/4/17.
//  Copyright © 2017 Cotery. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: Properties
    
    var meme: Meme!
    
    // MARK: Outlets
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.rightBarButtonItem?.title = "Edit"
        
        self.memeImageView!.image = meme.memedImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func editMeme(_ sender: Any) {
        let editController = self.storyboard!.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        editController.meme = self.meme
        self.navigationController?.pushViewController(editController, animated: true)
    }

}
