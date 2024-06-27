//
//  mailViewController.swift
//  chess
//
//  Created by akash kumar on 6/12/24.
//

import UIKit

class mailViewController: UIViewController {

    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var emailId: UILabel!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        stk1.layer.borderColor  = utils.chatFontColor.cgColor
        continueBtn.backgroundColor = utils.primGreen
        self.view.backgroundColor = utils.viewBG
        email.textColor = .white
        email.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        email.backgroundColor = utils.viewBG
        email.layer.borderColor = nil
        email.layer.borderWidth = 0
        stk1.layer.borderColor = UIColor.gray.cgColor
        stk1.layer.borderWidth = 2
        stk1.layer.cornerRadius = 5
        continueBtn.layer.cornerRadius = 5
        
        configNav()
        // Do any additional setup after loading the view.
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        print(" tapped ")
        self.navigationController?.popViewController(animated: true)
        
        // Your action
    }
    
    func configNav(){
        let backBtn = UIImageView(image: UIImage(systemName: "arrow.left"))
        backBtn.tintColor = .gray
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        backBtn.isUserInteractionEnabled = true
        backBtn.addGestureRecognizer(tapGestureRecognizer)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
      
    }
    
    @IBOutlet weak var stk1: UIStackView!
    
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
