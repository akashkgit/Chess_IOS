//
//  usernameViewController.swift
//  chess
//
//  Created by akash kumar on 6/12/24.
//

import UIKit

class usernameViewController: UIViewController {
    var pwd:String = ""
    @IBOutlet weak var username: UITextField!
    var email:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
