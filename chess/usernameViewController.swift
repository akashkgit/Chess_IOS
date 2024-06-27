//
//  usernameViewController.swift
//  chess
//
//  Created by akash kumar on 6/12/24.
//

import UIKit

class usernameViewController: UIViewController {
    
    var pwd:String = ""
    @IBOutlet weak var stk2: UIStackView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var contBtn: UIButton!
    @IBOutlet weak var username: UITextField!
    var email:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = utils.viewBG
        contBtn.backgroundColor = .white
        username.layer.borderColor = UIColor.lightGray.cgColor
        username.layer.borderWidth = 2
        contBtn.backgroundColor = utils.primGreen
        contBtn.tintColor = .white
        contBtn.layer.cornerRadius = 5
        username.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        username.backgroundColor = utils.viewBG
        username.layer.cornerRadius = 3
        userImage.layer.cornerRadius = 3
        
        
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
    
    
   
    //{ emailId: emailId, password: pwd, username: username }
    @IBAction func register(_ sender: Any) {
        
        
        struct toSend : Codable{
            var emailId:String!
            var password:String!
            var username:String!
        }
        
        
        var details = toSend(emailId: email, password: pwd, username: username.text)
        var data = try? JSONEncoder().encode(details)
        let url = URL(string: urls.signup)!
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
            let item = DispatchWorkItem(block: {
                self.performSegue(withIdentifier: "closesignup", sender: self)
            })
            DispatchQueue.main.sync(execute: item)
            
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                print ("got data: \(dataString)")
            }
            
        }
        task.resume()
        
        
        
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
