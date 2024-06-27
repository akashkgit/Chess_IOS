//
//  singupViewController.swift
//  chess
//
//  Created by akash kumar on 6/12/24.
//

import UIKit

class signupViewController: UIViewController {

    @IBOutlet weak var facebook: UIButton!
    @IBOutlet weak var google: UIButton!
    @IBOutlet weak var apple: UIButton!
    @IBOutlet weak var email: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var stk2: UIStackView!
    
    @IBOutlet weak var stk1: UIStackView!
    @IBOutlet weak var sBtn: UIButton!
    @IBAction func singup(_ sender: Any) {
    }
    @IBOutlet weak var stk3: UIStackView!
    func setupView(){
        self.view.backgroundColor = utils.viewBG
        configNav()
        sBtn.backgroundColor = utils.primGreen
        sBtn.layer.cornerRadius = 5
        for i in [stk1,stk2,stk3]{
            i?.backgroundColor = utils.barColor
            i?.layer.cornerRadius = 5
            
        }
        
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        print(" tapped ")
        self.navigationController?.popViewController(animated: true)
        
        // Your action
    }
    func configNav(){
        
        
        
        let  navc = navigationController
        let navb = navc!.navigationBar
        let navi = navigationItem
        
        guard self.navigationController != nil else {
            
            //print(" no nav ")
            return
        }
//        self.navigationController?.navigationBar.barStyle = .default
        let app = UINavigationBarAppearance()
        
        app.backgroundColor = UIColor(red: 33/255, green: 31/255, blue: 30/255, alpha: 1)
        
        navigationController?.navigationBar.standardAppearance = app
//        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.compactAppearance = app
        navigationController?.navigationBar.scrollEdgeAppearance = app
        
        
        
        let backBtn = UIImageView(image: UIImage(systemName: "arrow.left"))
        backBtn.tintColor = .gray
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        backBtn.isUserInteractionEnabled = true
        backBtn.addGestureRecognizer(tapGestureRecognizer)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
      
       
        
        
            
            let loginBtn = UIButton()
            loginBtn.setTitle( "login", for: .normal)
            loginBtn.addTarget(self, action:#selector(login), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: loginBtn)
//            navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: lbb2 ), UIBarButtonItem(customView: lbl)]
//            socialCon.contentMode = .scaleAspectFit
//            socialCon.translatesAutoresizingMaskIntoConstraints = false
            utils.nomask(loginBtn)
            
            
          
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: loginBtn)
       
        
//
        
        
//        navigationController?.navigationItem.titleView?.addSubview(v)
        
        
        
        
    }
    
    @objc func login(){
        performSegue(withIdentifier: "login", sender: self)
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
