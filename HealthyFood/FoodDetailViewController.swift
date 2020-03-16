//
//  FoodDetailViewController.swift
//  HealthyFood
//
//  Created by Sorrapong W on 13/3/2563 BE.
//  Copyright © 2563 Sorrapong W. All rights reserved.
//

import UIKit
import WebKit

class FoodDetailViewController: UIViewController {

    @IBOutlet weak var DetailWeb: WKWebView!
    var weburl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let DetailWeb = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.DetailWeb.frame.size.height))
        self.view.addSubview(DetailWeb)
        let url = URL(string: weburl)
        DetailWeb.load(URLRequest(url: url!))
    }
    
}
