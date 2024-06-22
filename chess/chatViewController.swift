//
//  chatViewController.swift
//  chess
//
//  Created by akash kumar on 6/17/24.
//

import UIKit


struct chatMsg {
    
}
struct classified {
    var msg : String
    var type : String
}

class chatViewController: UIViewController {
    var chatHistory: [classified]? = Array()
    var chatLblLst: [UILabel] = Array()
    
    
    @IBOutlet weak var movesContainer: UIView!
    @IBOutlet weak var chatHeader: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .
        
        self.contentView.backgroundColor = utils.viewBG
        self.view.backgroundColor = utils.viewBG
        self.scrollView.backgroundColor = utils.viewBG
        
        // Do any additional setup after loading the view.
        chatHeader.backgroundColor = utils.barColor
        msgToSend.backgroundColor = utils.chatBox
        chatHeader.textColor = .gray
        
        msgToSend.textColor = utils.chatFontColor
        sendIcon.tintColor = utils.chatFontColor
        self.view.bringSubviewToFront(closeBtn)
        setupMsg()
        closeBtn.tintColor = .gray
        
        contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        
    }
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBAction func close(_ sender: Any) {
        print("----- closing the chat -------")
        self.dismiss(animated: true)
    }
    
    @IBOutlet weak var sendIcon: UIButton!
    @IBAction func sendIcon(_ sender: Any) {
    }
    var lastConstraint: NSLayoutConstraint?
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var heightCntView: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var msgToSend: UITextField!
    @IBAction func sendMsg(_ sender: Any) {
        
      
        var lbl = UILabel()
        
        lbl.text = msgToSend.text
        lbl.textColor = .gray
        
        self.contentView.addSubview(lbl)
        var lastMsgLbl = chatLblLst.count > 0 ? self.chatLblLst[self.chatLblLst.count - 1].bottomAnchor : self.contentView.topAnchor
        let constraints = [lbl.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
         lbl.topAnchor.constraint(equalTo: lastMsgLbl , constant: 10)
         ]
        
        
        if let l = self.lastConstraint, self.chatLblLst.count > 0
        {
            let btn = self.chatLblLst[self.chatLblLst.count - 1]
            print(" removing last constrint ")
            self.contentView.removeConstraint(self.lastConstraint!)
        }
        let last = lbl.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)
        utils.activate([last])
        self.lastConstraint = last
        
        utils.activate(constraints)
        utils.nomask(lbl)
        self.chatLblLst.append(lbl)
        
        var conn = connection.getConnection()
        var m = msgModel(action: "matchManager", type: "chatMsg", choice: nil, src: MatchViewController.matchSession.myComp.name, dest:  MatchViewController.matchSession.oppComp.name, authorized: nil, coinMoved: nil, timingOption: nil, jwt: nil, chatMsg: msgToSend.text)
        
        print(" sending msg \(m)")
        conn!.send(m)
        
    }
    func setupMsg(){
        connection.getConnection()!.setHandler(.chat, {
            da in
            if let data = da as? msgModel{
                
                
                
                
                DispatchQueue.main.sync(execute: DispatchWorkItem(block: {
                    var lbl = UILabel()
                    var d = classified(msg: data.chatMsg!, type: "opp")
                    var lastMsgLbl = self.chatLblLst.count > 0 ? self.chatLblLst[self.chatLblLst.count - 1].bottomAnchor : self.contentView.layoutMarginsGuide.topAnchor
                    lbl.text = data.chatMsg
                    lbl.textColor = .gray
                    self.contentView.addSubview(lbl)
                    let constraints = [lbl.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
                                       lbl.topAnchor.constraint(equalTo: lastMsgLbl, constant: 10)
                    ]
                    
                    if let l = self.lastConstraint, self.chatLblLst.count > 0
                    {
                        let btn = self.chatLblLst[self.chatLblLst.count - 1]
                        self.contentView.removeConstraint(self.lastConstraint!)
                    }
                    let last = lbl.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 5)
                    utils.activate([last])
                    self.lastConstraint = last
                    
                    utils.activate(constraints)
                    utils.nomask(lbl)
                    self.chatLblLst.append(lbl)
                    
                    
                    
                }))
                
                
            }
            
            
            return nil
            
        })
        
    }
    }
