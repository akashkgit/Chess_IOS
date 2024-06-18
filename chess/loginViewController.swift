//
//  loginViewController.swift
//  chess
//
//  Created by akash kumar on 6/12/24.
//

import UIKit

class loginViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
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
