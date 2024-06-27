//
//  finalViewController.swift
//  chess
//
//  Created by akash kumar on 6/21/24.
//

import UIKit

class finalViewController: UIViewController {
    @IBOutlet weak var OppName: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    
    var timingOption = "1 Min"
    @IBOutlet weak var timingOuterStk: UIStackView!
    var opp:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        setupView()
        setupCB()
        print(" opp is \(opp!)")

        // Do any additional setup after loading the view.
    }
    
    func setupCB(){
        connection.getConnection()?.handlers[msgTypes.requestAck] = {
            data in
            
            
            print("<----- opening Matchviewcontroller -----?")
            DispatchQueue.main.sync {
            let sb = UIStoryboard.init(name: "Main", bundle: nil)
            let secondViewController = sb.instantiateViewController(withIdentifier: "matchView") as! MatchViewController
                let nextVc = secondViewController
            MatchViewController.matchSession.oppComp.name = self.opp
            MatchViewController.matchSession.myComp.name = userdata.username
            var  tf = timeFormat()
            tf.setSrc(self.timingOption)
            MatchViewController.matchSession.timingOption = tf
            
                self.navigationController!.pushViewController(nextVc, animated: true)
                    
            }
            return nil
            
        }
    }
    
    /*
     
     "action": "matchManager",
             "type": "requestInit",
             "dest": dest,
             "src": uname,
             "myCoin": mycoin,
             "timingOption": timingOption,
             "rated": rated
     
     
     */
    @IBAction func initReq(_ sender: Any) {
        
        
        var d = msgModel(action:"matchManager", type:"requestInit",  src : userdata.username, dest:self.opp,  timingOption:gameTime(type: "Bullet", option: self.timingOption) )
        connection.getConnection()?.send(d)
        print(" sending request ")
        
    }
    @IBOutlet weak var blackOption: UIButton!
    
    @IBOutlet weak var whiteOption: UIButton!
    @IBAction func selectBlack(_ sender: Any) {
        
        
        whiteOption.layer.borderWidth = 0
        blackOption.layer.borderWidth = 2
        
    }
    @IBAction func selectWhite(_ sender: Any) {
        
        
        whiteOption.layer.borderWidth = 2
        blackOption.layer.borderWidth = 0
        
    }
    @IBOutlet weak var rootStk: UIStackView!
    func setupView(){
        self.view.backgroundColor
        = utils.viewBG
        blackOption.layer.borderColor = utils.primGreen.cgColor
        whiteOption.layer.borderColor = utils.primGreen.cgColor
        timingOuterStk.layer.cornerRadius = 5
        timingOuterStk.backgroundColor = utils.chatBox
        playBtn.backgroundColor = utils.primGreen
        playBtn.layer.cornerRadius = 5
        playBtn.tintColor = .white
        blackOption.layer.cornerRadius = 5
        whiteOption.layer.cornerRadius = 5
        
        rootStk.tintColor = .gray
        OppName.text = self.opp!
        OppName.textColor = .white
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        print(" tapped ")
        self.navigationController?.popViewController(animated: true)

        // Your action
    }
    
    func configNav() -> Void {
        
        //        istack.addArrangedSubview(popup())
        
        //        stuck.addArrangedSubview(popup())
        let backBtn = UIImageView(image: UIImage(systemName: "arrow.left"))
        backBtn.tintColor = .gray
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        backBtn.isUserInteractionEnabled = true
        backBtn.addGestureRecognizer(tapGestureRecognizer)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        let title = UILabel()
        title.text = "Create Challenge"
        title.tintColor = .white
        title.textColor = .white
        title.font = UIFont(name: "Gill Sans", size: 30)
        self.navigationItem.titleView = title
        
        
//        let goTo = UITapGestureRecognizer(target: self, action: #selector(next(tapGestureRecognizer:)))
//        
//         self.friendStack.addGestureRecognizer(goTo)
//        
//        
        
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
