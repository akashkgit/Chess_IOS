//
//  mailViewController.swift
//  chess
//
//  Created by akash kumar on 6/12/24.
//

import UIKit

class mailViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var pwdVC = segue.destination as! passwordViewController
        pwdVC.email = self.email.text!
    }
}
