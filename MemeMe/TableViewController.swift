//
//  TableViewController.swift
//  MemeMe
//
//  Created by Kenneth Chen on 9/1/17.
//  Copyright © 2017 Cotery. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var memes = [Meme]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        self.tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.memes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        let meme = self.memes[(indexPath as NSIndexPath).row]

        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = "\(meme.topText) ... \(meme.bottomText)"
        
        return cell
    }

    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController?.pushViewController(detailController, animated: true)
    }

}
