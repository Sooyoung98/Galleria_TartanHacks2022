//
//  MintComplete.swift
//  GalleryX
//
//  Created by Won Woo Nam on 2/6/22.
//


import UIKit
import Alamofire
import FirebaseStorage

class MintController: UIViewController {
    
    @IBOutlet weak var tokenLabel: UILabel!
    
    @IBOutlet weak var finalmg: UIImageView!
    
    @IBOutlet weak var Home: UIButton!
    @IBOutlet weak var Mint: UILabel!
    @IBOutlet weak var Upload: UILabel!
    @IBOutlet weak var Choose: UILabel!
    @IBOutlet weak var backToHome: UIButton!
    @IBOutlet weak var KlayScope: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        var result = Int(String(count), radix: 16)!
        tokenLabel.text = "TOKEN ID: " + String(result)
        finalmg.image = finalImg
        
        Mint.layer.cornerRadius = 10
        Mint.layer.masksToBounds = true
        Choose.layer.cornerRadius = 10
        Choose.layer.masksToBounds = true
        Choose.layer.borderWidth = 2
        Choose.layer.borderColor = CGColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1.0)
        Upload.layer.cornerRadius = 10
        Upload.layer.masksToBounds = true
        Upload.layer.borderWidth = 2
        Upload.layer.borderColor = CGColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1.0)
        
        finalmg.layer.cornerRadius = 15
        KlayScope.layer.cornerRadius = 10
    }
    @IBAction func Homee(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func clicked(_ sender: Any) {
        
        if let url = URL(string: "https://baobab.scope.klaytn.com/") {
            UIApplication.shared.open(url)
        }
    }
}


extension UIView {
    func blink(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, alpha: CGFloat = 0.0) {
        UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseInOut, .repeat, .autoreverse], animations: {
            self.alpha = alpha
        })
    }
}
