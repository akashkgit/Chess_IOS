//
//  playAFriend.swift
//  chess
//
//  Created by akash kumar on 5/29/24.
//

import UIKit

class playAFriend: UIViewController {

    @IBOutlet weak var contentStkView: UIStackView!
    @IBOutlet weak var searchBox: UITextField!
    @IBOutlet weak var stk3: UIStackView!
    @IBOutlet weak var stk2: UIStackView!
    @IBOutlet weak var stk1: UIStackView!
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var inviteFrendsSubTitle: UILabel!
    @IBOutlet weak var InviteFrends: UILabel!
    @IBOutlet weak var findFrendsSubTitle: UILabel!
    @IBOutlet weak var findFrendsTitle: UILabel!
    @IBOutlet weak var challengeLinkSubTitle: UILabel!
    @IBOutlet weak var challengeLinkTitle: UILabel!
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        print(" tapped ")
        self.navigationController?.popViewController(animated: true)

        // Your action
    }
    func configNav() -> Void {
        let backBtn = UIImageView(image: UIImage(systemName: "arrow.left"))
        backBtn.tintColor = .gray
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        backBtn.isUserInteractionEnabled = true
        backBtn.addGestureRecognizer(tapGestureRecognizer)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        let title = UILabel()
        title.text = "Play a Friend"
        title.tintColor = .white
        title.font = UIFont(name: "Gill Sans", size: 30)
        title.textColor = .white
        self.navigationItem.titleView = title
    }
    /*
     setFName(event.target.value);
        let res = ["player2chess@gmail.com", "player3chess@gmail.com"]
        setFriendList(res);
        if (ws) {
            ws.send(JSON.stringify({ "action": "friendList", "startsWith": event.target.value }));
            setFriendList(["......loading"]);
            ws.addEventListener("message", function (message: any) {
                // alert(message);
                console.log(" message : ", message);
                let friendList = JSON.parse(message.data).friendList;
                if (friendList) {
                    console.log(" friendList: ", message);
                    setFriendList(friendList.map((obj: any) => obj["emailId"]))
                }
                // let json=JSON.parse(message);
                // setFriendList(json.friendList);
            })
        }
        else {
            setFriendList(["...... selector not available. Kindly try again later or report the issue to the support team if reccurs"]);
        }
     
     
     */
    @IBAction func changed(_ sender: UITextView) {
        
        print("friend-changed")
        guard sender.text != "" else {
            return
        }
        connection.getConnection()!.send(
        msgModel(action:"friendList",startsWith: sender.text))
        connection.getConnection()?.setHandler(.friendList, { [self]
            data in
            if let d = data as? msgModel, let lfrnds = d.friendList{
//                print("-f-l")
//                print(d)
                
                
                DispatchQueue.main.sync {
                    if self.newStk != nil {
                        print("-f-r \(self.newStk!)")
                        (self.newStk!).removeFromSuperview()
                    }
                    self.newStk = UIStackView()
                    self.newStk!.axis = .vertical
                    self.newStk!.spacing = 10
                    
//                    self.newStk?.backgroundColor = .red
                    utils.nomask([self.newStk!])
                    
                }
                for (id,i) in lfrnds.enumerated() {
                    
                    
                    print("friend \(i["emailId"])")
                    DispatchQueue.main.sync {
                        
                        var card = friendCard()
                        utils.nomask(card)
                        
                        utils.activate([card.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.1)])
                        self.newStk!.addArrangedSubview(card)
//                        self.view.layoutIfNeeded()
                        
                        card.playerName.text = i["emailId"]
                        card.playerId.text = "\(i["emailId"]!)_id"
                        card.playerScore.text = "\(1000 + id)"
                        card.playerStatus.text = "online \(id + 1) seconds ago"
                        
                        card.addGestureRecognizer(  UITapGestureRecognizer(target: self, action: #selector(finalise(tapGestureRecognizer:))))
                    }
                    
                    
                }
                DispatchQueue.main.sync {
                    self.contentStkView.addArrangedSubview(self.newStk!)
                }
            }
            return nil
        })
        
        
    }
    
    @objc func finalise( tapGestureRecognizer: UITapGestureRecognizer) {
        var card  = (tapGestureRecognizer.view as? friendCard)
        self.opp = card?.playerName.text
        performSegue(withIdentifier: "finalise", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var dest = segue.destination as! finalViewController
        dest.opp = self.opp
        
    }
    var opp:String?
    var newStk:UIStackView?
    @IBOutlet weak var frendListStackView: UIStackView!
    func setupView(){
        self.view.backgroundColor = utils.viewBG
        play.addTarget(self, action: #selector(playFn), for: .touchUpInside)
        for i in [stk1,stk2,stk3]{
            i!.backgroundColor = utils.barColor
        }
        
        searchBox.backgroundColor = utils.chatBox
        searchStk.backgroundColor = utils.chatBox
        
        
    }
    @objc func playFn(){
        print (" starting to play ")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configNav()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var searchStk: UIStackView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
