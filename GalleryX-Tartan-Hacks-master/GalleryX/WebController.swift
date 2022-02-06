//
//  WebController.swift
//  GalleryX
//
//  Created by Won Woo Nam on 2/6/22.
//

import UIKit
import Alamofire
import FirebaseStorage
import WebKit

class WebController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @IBOutlet weak var mainView: WKWebView!
    
    override func viewDidLoad() {
        mainView.navigationDelegate = self
        mainView.uiDelegate = self
        
        let url = URL(string: "https://baobab.scope.klaytn.com/")!
        mainView.load(URLRequest(url: url))
        
        mainView.allowsBackForwardNavigationGestures = true
    }
    
    
}
