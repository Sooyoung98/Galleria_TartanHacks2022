//
//  TempController.swift
//  GalleryX
//
//  Created by Won Woo Nam on 2/6/22.
//

import UIKit
import Alamofire
import FirebaseStorage

class TempController: UIViewController {
    
    @IBOutlet weak var Choose: UILabel!
    @IBOutlet weak var Upload: UILabel!
    @IBOutlet weak var Mint: UILabel!
    @IBOutlet weak var Upload1: UIButton!
    
    @IBOutlet weak var Upload2: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        Choose.layer.cornerRadius = 10
        Choose.layer.masksToBounds = true
        Mint.layer.cornerRadius = 10
        Mint.layer.masksToBounds = true
        Mint.layer.borderWidth = 2
        Mint.layer.borderColor = CGColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1.0)
        Upload.layer.cornerRadius = 10
        Upload.layer.masksToBounds = true
        Upload.layer.borderWidth = 2
        Upload.layer.borderColor = CGColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1.0)
        
        Upload1.layer.cornerRadius = 10
        Upload2.layer.cornerRadius = 10
    }
}
