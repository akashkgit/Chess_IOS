//
//  passwordViewController.swift
//  chess
//
//  Created by akash kumar on 6/12/24.
//

import UIKit

class passwordViewController: UIViewController {

    @IBOutlet weak var privacy: UIImageView!
    
    @IBOutlet weak var contBtn: UIButton!
    
    @IBOutlet weak var stk1: UIStackView!
    @IBOutlet weak var password: UITextField!
    var email:String = ""
    var pwd:String = ""
    var eyeOpen:Bool = false
    @objc func toggler(tapGestureRecognizer:UITapGestureRecognizer){
        
        print("eyed")
        eyeOpen = !eyeOpen
        password.isSecureTextEntry = !eyeOpen
        if(eyeOpen){
            privacy.image = UIImage(systemName: "eye.fill")
            
        }
        else {
            privacy.image = UIImage(systemName: "eye.slash")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = utils.viewBG
        
        privacy.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggler(tapGestureRecognizer:))))
        privacy.isUserInteractionEnabled = true
        stk1.layer.borderColor = UIColor.gray.cgColor
        stk1.layer.borderWidth = 2
        contBtn.backgroundColor = utils.primGreen
        contBtn.layer.cornerRadius = 5
        contBtn.tintColor = .white
        
        
        stk1.layer.cornerRadius = 5
        
        password.backgroundColor = utils.viewBG
        password.layer.borderWidth = 0
        password.textColor = .white
        password.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        configNav()
        // Do any additional setup after loading the view.
    }
    func configNav(){
        let backBtn = UIImageView(image: UIImage(systemName: "arrow.left"))
        backBtn.tintColor = .gray
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        backBtn.isUserInteractionEnabled = true
        backBtn.addGestureRecognizer(tapGestureRecognizer)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
      
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        print(" tapped ")
        self.navigationController?.popViewController(animated: true)
        
        // Your action
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
