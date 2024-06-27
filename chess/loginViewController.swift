//
//  loginViewController.swift
//  chess
//
//  Created by akash kumar on 6/12/24.
//

import UIKit

class loginViewController: UIViewController {

    @IBOutlet weak var stk2: UIStackView!
    @IBOutlet weak var contBtn: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var privacy: UIImageView!
    @IBOutlet weak var stk1: UIStackView!
    @IBOutlet weak var username: UITextField!
    
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
        configNav()
        self.view.backgroundColor = utils.viewBG
        contBtn.backgroundColor = utils.primGreen
        contBtn.layer.cornerRadius = 10 
        for i in [b1,b2,b3] {
            i?.backgroundColor = utils.barColor
            i?.layer.cornerRadius = 10
            
        }
        
        
        stk1.layer.cornerRadius = 10
        stk2.layer.cornerRadius = 10
        username.backgroundColor = utils.chatBox
        password.backgroundColor = utils.chatBox
        
        privacy.isUserInteractionEnabled = true
        stk1.backgroundColor = utils.chatBox
        stk2.backgroundColor = utils.chatBox
        privacy.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggler(tapGestureRecognizer:))))
        username.layer.borderWidth = 0
        username.layer.borderColor = utils.chatBox.cgColor
        password.layer.borderWidth = 0
        password.layer.borderColor = utils.chatBox.cgColor
        
        
        // Do any additional setup after loading the view.
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        print(" tapped ")
        self.navigationController?.popViewController(animated: true)
        
        // Your action
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func configNav(){
        let backBtn = UIImageView(image: UIImage(systemName: "arrow.left"))
        backBtn.tintColor = .gray
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        backBtn.isUserInteractionEnabled = true
        backBtn.addGestureRecognizer(tapGestureRecognizer)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
      
    }
    @IBAction func login(_ sender: Any) {
        
        struct toSend : Codable{
            var emailId:String!
            var password:String!
//            var username:String!
        }
        
        
        var details = toSend(emailId: username.text, password: password.text)
        var data = try? JSONEncoder().encode(details)
        let url = URL(string: urls.login)!
        var request = URLRequest(url:url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        print(" sending \(details)")
        let task =  URLSession.shared.uploadTask(with: request, from: data) {
            data, response, error in
            
            print("response recvd ////")
            if let error = error {
                    print ("error: \(error)")
                    return
                }
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                print ("server error")
                return
            }
            let dataString = String(data: data!, encoding: .utf8)
            print ("got data: \(dataString)")
           
                
                
                let decoder = JSONDecoder()
                let resp = try? decoder.decode(loginResponse.self , from: data!)
                  print("decoded --> ", resp)
            
            if resp!.found {
                UserDefaults.standard.setValue(resp!.jwt, forKey: "jwt")
                UserDefaults.standard.setValue(self.username.text, forKey: "username")
                UserDefaults.standard.setValue(true, forKey: "login")
                
            }
            
            
            let item = DispatchWorkItem(block: {
                self.performSegue(withIdentifier: "closelogin", sender: self)
            })
            DispatchQueue.main.sync(execute: item)
            
           
            
            
            
        }
        task.resume()
        
    }
}
