//
//  passwordViewController.swift
//  chess
//
//  Created by akash kumar on 6/12/24.
//

import UIKit

class passwordViewController: UIViewController {

    
    @IBOutlet weak var password: UITextField!
    var email:String = ""
    var pwd:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let unameVC = segue.destination as! usernameViewController
        unameVC.email = email
        unameVC.pwd = password.text!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
