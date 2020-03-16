//
//  ViewController.swift
//  HealthyFood
//
//  Created by Sorrapong W on 12/3/2563 BE.
//  Copyright © 2563 Sorrapong W. All rights reserved.
//

import UIKit
import AFNetworking

class LoginViewController: UIViewController {

    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: Any) {
        let manager = AFHTTPRequestOperationManager()
        let requestSerializer:AFJSONRequestSerializer = AFJSONRequestSerializer()
        
        requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        
        manager.requestSerializer = requestSerializer
        var parameters = ["username":username.text!, "password": password.text!]
        
        manager.post("http://localhost:8080/login", parameters: parameters, success: { (operation, responseObject) in
            let json = responseObject as? Dictionary<String,Any>
            
            
            if json!["STATUS"]! as! String == "success" {
                let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let mainViewController : MainViewController = mainStoryboard.instantiateViewController(identifier: "mainmenu") as! MainViewController
                mainViewController.modalPresentationStyle = .fullScreen
                self.present(mainViewController, animated: true)
            }else {
                let alert = UIAlertController(title: "ไม่สามารถเข้าสู๋ระบบได้", message: json!["MESSAGE"]! as! String, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
            
        }) { (operation, error) in
            print(error)
        }
    }
    
}

