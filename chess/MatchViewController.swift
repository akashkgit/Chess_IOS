//
//  MatchViewController.swift
//  chess
//
//  Created by akash kumar on 5/29/24.
//

import UIKit

struct timeComp {
    var mm = 1
    var ss = 5
}
struct dets {
    var myCoin:String = "black"
    var clkComp:timeComp = timeComp()
    var name:String! = ""
}
struct matchState {
    var  myComp:dets = dets()
    var  oppComp:dets = dets()
    var login:Bool = false
    var username:String = ""
    
    
}
class MatchViewController: UIViewController, URLSessionWebSocketDelegate{
    static var dryRun = false
    static var boardBounds:[String:CGFloat]? = [String:CGFloat]()
    @IBOutlet weak var myIcon: UIImageView!
    @IBOutlet weak var oppIcon: UIImageView!
    @IBOutlet weak var oppClock: UILabel!
    @IBOutlet weak var oppClkStk: UIStackView!
    
    
    @IBOutlet weak var chatWindow: UIButton!
    @IBOutlet weak var myName: UILabel!
    @IBOutlet weak var oppName: UILabel!
    @IBOutlet weak var oppClkIcon: UIImageView!
    
    
    @IBOutlet weak var oppLCoins: UIStackView!
    @IBOutlet weak var myLCoins: UIStackView!
    @IBOutlet weak var myClkIcon: UIImageView!
    
    @IBOutlet weak var myClkStk: UIStackView!
    
    @IBOutlet weak var myClk: UILabel!

    
    
    
    @IBOutlet weak var boardImg: UIImageView!
    static var  matchSession = matchState()
    @IBOutlet weak var moveHistory: UIScrollView!
    @IBOutlet weak var boardView: UIView!
    // ------ black coins ----------
    
    @IBOutlet weak var bp4: UIButton!
    
    @IBOutlet weak var br1: UIButton!
    
    @IBOutlet weak var bq: UIButton!
    @IBOutlet weak var bh1: UIButton!
    @IBOutlet weak var bb1: UIButton!
    
    
    
    @IBOutlet weak var bk: UIButton!
    
    @IBOutlet weak var bb2: UIButton!
    
    
    

    
    @IBOutlet weak var br2: UIButton!
    
    @IBOutlet weak var bp1: UIButton!
    
    @IBOutlet weak var bp2: UIButton!
    
    
    @IBOutlet weak var bp3: UIButton!
    
    
    
    
    
    @IBOutlet weak var bp5: UIButton!
    
    @IBOutlet weak var bp6: UIButton!
    
    @IBOutlet weak var bp7: UIButton!
    
    
    @IBOutlet weak var bp8: UIButton!
    
    @IBOutlet weak var bh2: UIButton!
    
    // ----- white coins ------------
    
    @IBOutlet weak var wp1: UIButton!
    
    @IBOutlet weak var wp2: UIButton!
    
    @IBOutlet weak var wp3: UIButton!
    
    
    @IBOutlet weak var wp4: UIButton!
    
    @IBOutlet weak var wp5: UIButton!
    
    @IBOutlet weak var wp6: UIButton!
    
    @IBOutlet weak var wp7: UIButton!
    
    @IBOutlet weak var wp8: UIButton!
    
    @IBOutlet weak var wr1: UIButton!
    
    
    @IBOutlet weak var wh1: UIButton!
    
    @IBOutlet weak var wb1: UIButton!
    
    
    @IBOutlet weak var wq: UIButton!
    
    @IBOutlet weak var wk: UIButton!
    
    @IBOutlet weak var wb2: UIButton!
    
    @IBOutlet weak var wh2: UIButton!
    
    @IBOutlet weak var wr2: UIButton!
    var mapping:[String: coinInfo] = [:]
    static var reverseMap :[UIButton:coinInfo] = [:]
    private var activeEl: UIButton? = nil
    private var ws:URLSessionWebSocketTask? = nil
    
    
    func setView() {
        var nib = UINib(nibName: "custview", bundle: Bundle(for: type(of: self)))
        nib.instantiate(withOwner: self)
//        self.view.addSubview(popup)
        
    }

    func swapPos(_ coin1:UIButton!, _ coin2:UIButton!){
        
//        print("\(coin1.frame)-\(coin2.frame)")
//        var t = coin1.constraints
//        coin1.constraints = coin2.constraints
//        coin2.constraints = t
////        print("\t\t\(coin1.frame)-\(coin2.frame)")
        ///
        ///var t
//        var  t1 = coin1.frame
//        var  t2 = coin1.autoresizingMask
//        coin1.frame  = coin2.frame
//        coin1.autoresizingMask = coin2.autoresizingMask
//        coin2.frame = t1
//        coin2.autoresizingMask = t2
        
        // -- correct code -----
//        for i in 0...1 {
//            let temp_constraints = constraints![coin1]![i].constant
//            
//            
//            constraints![coin1]![i].constant = constraints![coin2]![i].constant
//            constraints![coin2]![i].constant = temp_constraints
//        }
//        
        
        
    }
    
    func swap(){
        if (MatchViewController.matchSession.myComp.myCoin != "white"){
            
            swapPos(br1,wr1)
            swapPos(bh1,wh1)
            swapPos(bb1,wb1)
            swapPos(bq,wq)
            swapPos(bk,wk)
            swapPos(bb2,wb2)
            swapPos(bh2,wh2)
            swapPos(br2,wr2)
            swapPos(bp1,wp1)
            swapPos(bp2,wp2)
            swapPos(bp3,wp3)
            swapPos(bp4,wp4)
            swapPos(bp5,wp5)
            swapPos(bp6,wp6)
            swapPos(bp7,wp7)
            swapPos(bp8,wp8)
          
          
            
        }
    }
    
    @IBAction func clicked(_ sender: UIButton!) {
        
        if var prevEl = activeEl {
            
            print(" tap 2 \(MatchViewController.reverseMap[prevEl]!.boxId) \(MatchViewController.reverseMap[sender]!.boxId)")
            moveCoinHelper(nil,nil,sender)
            activeEl = nil
            //stop timer
            
            
            
        }
        else {
            
            var btn = sender
            activeEl = btn
            print(" tap 1 \(MatchViewController.reverseMap[activeEl!]!.boxId)")
            print(activeEl)
        }
        
    }
    
    
    
    @IBAction func oppTap(_ sender: UIButton) {
        print("tapped ")
       
        
        
        
    }
    
    @objc func moveFn( _ sender: UITapGestureRecognizer){
        print(" sender \(sender.state)")
        guard activeEl != nil else {print("no active element");return}
        if ( sender.state == UITapGestureRecognizer.State.ended ){
            
            moveMyCoin(sender)
            activeEl = nil
        }
    }
    
    
    func moveMyCoin(_ sender:UITapGestureRecognizer){
        // donot forget to stop timer
        
        
        print(" ended ")
        let loc = sender.location(in: self.boardView)
        print("location @ \(sender.location(in: self.boardView))")
        moveCoinHelper(loc.x,loc.y, nil)
        /// --- new location calculation
       // commenting for move checking purpose - the below line is needed
        //send(toSend)
        
        
        
    }
    
    
    
func kingExposed(_ view: MatchViewController) -> Bool{
    
    var king =  MatchViewController.matchSession.myComp.myCoin == "white" ? view.wk : view.bk
    
    for (k,v) in MatchViewController.reverseMap {
        
        var info: coinInfo = v as coinInfo
        print(" opp coin is \(MatchViewController.matchSession.oppComp.myCoin ): \(info.type)")
        if info.type == MatchViewController.matchSession.oppComp.myCoin {
            MatchViewController.dryRun = true
            var coinName = info.name
            var  temp = view.activeEl
            view.activeEl = k
            print(" ##### checking \(info.name) \(MatchViewController.reverseMap[king!]?.name) ########")
            
            
            var res = moveCoinHelper(nil, nil, king)!
            activeEl = temp
            MatchViewController.dryRun = false
            switch(res){
            case status.granted_killing :
                print("-----------> killing possible <-----------------")
                return true
            default :
                print("-------> default <------------------------------")
            }
        
            
            
            
        }
    }
    return false
}

    
func checkcheck(_ view: MatchViewController) -> Bool{
    
    var king =  MatchViewController.matchSession.myComp.myCoin == "white" ? view.bk  : view.wk
    
    for (k,v) in MatchViewController.reverseMap {
        
        var info: coinInfo = v as coinInfo
        print(" opp coin is \(MatchViewController.matchSession.myComp.myCoin ): \(info.type)")
        if info.type == MatchViewController.matchSession.myComp.myCoin {
            MatchViewController.dryRun = true
            var coinName = info.name
            var  temp = view.activeEl
            view.activeEl = k
            print(" ##### checking \(info.name) \(MatchViewController.reverseMap[king!]?.name) ########")
            
            
            var res = moveCoinHelper(nil, nil, king)!
            activeEl = temp
            MatchViewController.dryRun = false
            switch(res){
            case status.granted_killing :
                print("-----------> killing possible <-----------------")
                return true
            default :
                print("-------> default <------------------------------")
            }
        
            
            
            
        }
    }
    return false
}



    
    func moveCoinHelper(_ locationX:CGFloat?, _ locationY: CGFloat?, _ dest:UIButton?) ->status?{
        var locX = locationX
        var locY = locationY
        if ( dest != nil ) {
            print(" DDDD EEEEE SSSS TTTTTTT  ----->| \(MatchViewController.reverseMap[dest!]!.name)")
            locX = dest?.frame.minX
            locY = dest?.frame.minY
            
           
        }
        let frm = activeEl?.frame
        let width = Int(frm!.width)
        let height = Int(frm!.height)
        let oldX = Int(frm!.minX)
        let oldY = Int(frm!.minY)
        
        let test = CGRect(x: oldX, y: oldY, width: 10, height: 10)
        let testpt = UIImageView(frame: test)
        testpt.backgroundColor = .blue
        
        self.boardView.addSubview(testpt)
        
        
        var dY = oldY - Int(locY!)
        var dX = oldX - Int( locX!)
        
        var midY = Int((dY / height))
        var midX = Int(dX / width)
        
        var newY:Int = oldY - (( Int((dY / height))) * height)
        if( dY > 0 ) {newY = newY - height}
        //            if ( dY < 0 && abs(dY) >= height ) { newY = newY + height }
        var newX:Int =  oldX - (( Int(dX / width) ) * width)
        if ( dX > 0) {newX = newX - width}
        let rect = CGRect(x: newX, y: newY, width: 10, height: 10)
        let pt = UIImageView(frame: rect)
        pt.backgroundColor = .red
        
        self.boardView.addSubview(pt)
        print("ox:\(oldX) oy:\(oldY) w:\(width) h:\(height) lx:\(locX) ly:\(locY) dy:\(dY) dx:\(dX) dy/h:\(dY/height)y: \((( (dY / height) + 1) * height)) /x: \((( (dX / width) ) * width)) ny: \(newY) nx:\(newX)")
        //        activeEl?.frame = CGRect(x: CGFloat(newX) , y: CGFloat(newY), width: CGFloat(frm!.width), height: CGFloat(frm!.height))
        let btnDets = MatchViewController.reverseMap[activeEl!]
        var xc = MatchViewController.reverseMap[activeEl!]!.constraintLst[0]
        var yc = MatchViewController.reverseMap[activeEl!]!.constraintLst[1]
        
        
        
        //{"action":"matchManager","type":"play","coinMoved":{"coin":{"type":"p","boxId":"2e","curPos":"4e"},"Pos":[0,-2],"kill":{"kill":false},"check":false},"dest":"bib","src":"pip"}
        
        var t = btnDets!.name.split(separator: "")
        var row  =  btnDets!.position.split(separator: "")[0]
        var col  =  btnDets!.position.split(separator:"")[1]
        var curPos = ""
        if(MatchViewController.matchSession.myComp.myCoin == "black"){
            if( (activeEl!.frame.minY - (locY!)) >= 0 && dest == nil ) { midY = midY + 1 }
            
            
            var nr = Int(row.unicodeScalars.first!.value) -  midY
            //            nr = nr > 8 ? nr - 8 : nr
            if (  (activeEl!.frame.minX - (locX!))  > 0 && dest == nil ) {
                
                    print("\n +++++++ midx+1 (1) ++++++++\n")
                midX = midX + 1
            }
            
            else if (  abs(activeEl!.frame.minX - (locX!))  > 0.8 * activeEl!.frame.width && abs(activeEl!.frame.minX - (locX!))  <  activeEl!.frame.width ) {
                
                
                midX = midX + ((activeEl!.frame.minX - (locX!))  > 0 ? 1 : -1)
                
                print("\n +++++++ midx+\((activeEl!.frame.minX - (locX!))  > 0 ? 1 : -1)(2) ++++++++\n")
            }
            var nc = String(UnicodeScalar(Int(col.unicodeScalars.first!.value) + midX)!)
            //            nc =  nc > "h" ? String("a".unicodeScalars.first!.value + (nc.unicodeScalars.first!.value - "h".unicodeScalars.first!.value)) : nc
            print("\(row):\(Int(row.unicodeScalars.first!.value) ) - dy:\(midY) - > \(nr) ")
            print("\(col):\(Int(col.unicodeScalars.first!.value) ) - dx:\(midX) - > \(nc) \(abs(activeEl!.frame.minX - (locX!)) ) \(activeEl!.frame.width ) \(0.8 * activeEl!.frame.width ) \(abs(activeEl!.frame.minX - (locX!))  > 0.8 * activeEl!.frame.width )")
            curPos = String(Character(UnicodeScalar(nr)!) ) + nc
            print("cur pos is \(curPos)")
            
        }
        else{
            var nr = Int(row.unicodeScalars.first!.value) + midY
            //            nr = nr > 8 ? nr - 8 : nr
            
            var nc = String(Int(col.unicodeScalars.first!.value) - midX)
            //            nc =  nc > "h" ? String("a".unicodeScalars.first!.value + (nc.unicodeScalars.first!.value - "h".unicodeScalars.first!.value)) : nc
            print("\(row):\(Int(row.unicodeScalars.first!.value) ) - dy:\(midY) - > \(nr)")
            print("\(col):\(Int(col.unicodeScalars.first!.value) ) - dx:\(midX) - > \(nc)")
            curPos = String(nr) + nc
        }
        
        // ------ checking  ------------
        print(" calling ......  \(String(t[1])) handler ")
        var res = moveMapping[String(t[1])]!(activeEl,[midX, midY], dest)
        print(" res is \(res)")
        switch (res){
            
        case let x where x == status.granted_plain  || x == status.granted_killing:
            if(MatchViewController.dryRun  ){
//                MatchViewController.skip = activeEl
//                let exposed = kingExposed(self)
//                MatchViewController.skip = nil
//                if(exposed){
//                    return status.prohibited_inCorrentPattern
//                }
                return x
            }
            else {
                print(" ! suceess you can move  - returning \(x)");
            }
                
            
        
    default :
        print(" no bro! wrong move ")
            return status.prohibited_inCorrentPattern
    }
        
        
        
        
        // -----------------------------
        
        btnDets?.position = curPos
       
        
        if( !MatchViewController.dryRun) {
            if( dest == nil ){
                
                var txc = xc.constant, tyc = yc.constant
                xc.constant = CGFloat(newX)
                yc.constant = CGFloat(newY)
                self.view.layoutIfNeeded()
                print(" udpated constraint \(xc.constant) \(yc.constant)")
//                MatchViewController.skip = activeEl
                let exposed = kingExposed(self)
//                MatchViewController.skip = nil
                if(exposed){
                    print("?????????? reversing coin move as its not allowed ???????????")
                    xc.constant =  txc
                    yc.constant = tyc
                    return status.prohibited_inCorrentPattern
                }
                
                
            }
            else {
                var  sender_xc = MatchViewController.reverseMap[dest!]!.constraintLst[0]
                var  sender_yc = MatchViewController.reverseMap[dest!]!.constraintLst[1]
                var activeEl_xc = MatchViewController.reverseMap[activeEl!]!.constraintLst[0], txc = activeEl_xc.constant
                var activeEl_yc = MatchViewController.reverseMap[activeEl!]!.constraintLst[1], tyc = activeEl_yc.constant
                
                
                
                
                activeEl_xc.constant = sender_xc.constant
                activeEl_yc.constant = sender_yc.constant
      
                
                    MatchViewController.skip = activeEl
                    let exposed = kingExposed(self)
                    MatchViewController.skip = nil
                    if(exposed){
                        print("????? reverting coin move as not allowed - 2 ??????")
                        activeEl_xc.constant = txc
                        activeEl_yc.constant = tyc
                        self.boardView.addSubview(dest!)
                        return status.prohibited_inCorrentPattern
                    }
            }
            self.view.layoutIfNeeded()
            let exposed = checkcheck(self)
//            
//            "{\"action\":\"matchManager\",\"type\":\"play\",\"coinMoved\":{\"coin\":{\"type\":\"p\",\"boxId\":\"2e\",\"curPos\":\"x5d\"},\"Pos\":[-1,-1],\"kill\":{\"kill\":true,\"dataPos\":\"7d\"},\"check\":fal
            
            let coin_ = Coin(type: String(t[1]) , boxId: btnDets!.boxId, curPos: curPos)
            var toSend = msgModel(action:"matchManager", type :"play",  src: MatchViewController.matchSession.myComp.name, dest:MatchViewController.matchSession.oppComp.name,coinMoved : chess.move(coin:coin_,  Pos:[-1 * midX, -1 * midY], kill: killer(kill: dest != nil,dataPos: dest != nil ? MatchViewController.reverseMap[dest!]!.boxId! : ""), check: exposed) )
            
//            if(dest != nil){
//                dest?.removeFromSuperview()
//                MatchViewController.reverseMap[dest!]?.constraintLst[2].constant = 10
//                MatchViewController.reverseMap[dest!]?.constraintLst[3].constant = 10
//                self.oppLCoins.addArrangedSubview(dest!)
//            }
            if(dest != nil){
                dest!.removeFromSuperview()
                MatchViewController.reverseMap[dest!]!.constraintLst[2].constant = 30
                MatchViewController.reverseMap[dest!]!.constraintLst[3].constant = 30
                dest!.contentMode = .scaleAspectFit
                print(" SIZE SIZE SIZE 2", dest!.constraints)
                                self.oppLCoins.addArrangedSubview(dest!)
            }
            print("toSend \(toSend)")
                
            connection.getConnection()!.send(toSend)
//            send(toSend)
        }
        
//        "{\"action\":\"matchManager\",\"type\":\"play\",\"coinMoved\":{\"coin\":{\"type\":\"p\",\"boxId\":\"2e\",\"curPos\":\"x5d\"},\"Pos\":[-1,-1],\"kill\":{\"kill\":true,\"dataPos\":\"7d\"},\"check\":fal
        
       
            return nil
    }
    func configNav(){
        let app = UINavigationBarAppearance()
        var gr = UITapGestureRecognizer(target: self, action: #selector(moveFn))
        
        self.view.addGestureRecognizer(gr)
        app.backgroundColor = utils.navColor
        
        navigationController?.navigationBar.standardAppearance = app
//        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.compactAppearance = app
        navigationController?.navigationBar.scrollEdgeAppearance = app
        let v = UIImageView()
        v.image = UIImage(named:"clogo")
//        v.widthAnchor.constraint(equalToConstant: 55).isActive = true
        v.contentMode = .scaleAspectFit
        v.heightAnchor.constraint(equalToConstant: 40).isActive = true
        v.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        v.backgroundColor = .systemPink
        navigationItem.titleView = v
        navigationItem.hidesBackButton = true
        
    }
    
    func send(_ data: msgModel? = msgModel(action: "matchManager", type: "requestAck", choice: "accept", src: "pip", dest: "bib", coinMoved: nil)){
        //{ action: "matchManager", type: "requestAck", "choice": "accept", "src": src, "dest": localStorage.getItem("username") }
        // {"action":"matchManager","type":"play","coinMoved":{"coin":{"type":"p","boxId":"2e","curPos":"4e"},"Pos":[0,-2],"kill":{"kill":false},"check":false},"dest":"bib","src":"pip"}
      
        struct msg: Codable {
            var action:String
            var type:String
            var choice:String
            var src:String
            var dest:String
            var coinMoved:move?
            
            
        }
        
        struct move: Codable {
        var coin: Coin
        var Pos:[Int]
            var kill: [String:Bool]
            var check :Bool
        }
        struct Coin : Codable{
        var type: String
        var boxId:String
        var curPos:String
        }
        let jen = JSONEncoder()
        var res = try? jen.encode( data )
        let json = String(data:res!, encoding: String.Encoding.utf8)
        print(" sending data \(json)")
        ws!.send(URLSessionWebSocketTask.Message.string(json!)){
            error in
            print(" send result : \(error) !")
        }
    }
    func processReq(_ ress:Any?){
        var res = ress! as! msgModel
        if (res.type == "play") {
            print(" processing the move")
            var boxId = res.coinMoved?.coin.boxId
            var curPos = res.coinMoved?.coin.curPos
            var pos = res.coinMoved?.Pos
            var kill = res.coinMoved?.kill
            var src = res.src
            var dest = res.dest
            var item = self.mapping[boxId!]
            
            var btn = item?.btn
            
            DispatchQueue.main.async {
                print("old constraint \(item?.constraintLst[0].constant ) \(item?.constraintLst[1].constant ) \(btn!.frame.width) \(btn!.frame.height)")
                item?.constraintLst[0].constant = item!.constraintLst[0].constant + CGFloat(pos![0] * -1 ) * btn!.frame.width
                item?.constraintLst[1].constant = item!.constraintLst[1].constant + CGFloat(pos![1] * -1 ) * btn!.frame.height
                print("new constraint \(item?.constraintLst[0].constant ) \(item?.constraintLst[1].constant )")
                
                if let killed = kill?.kill, let dPos = kill?.dataPos {
                    let killedCoin = self.mapping[dPos]?.btn
                    print(" removing killed coin:\(dPos )->\(killedCoin)")
                    
                    
                    print(" SIZE SIZE SIZE ", killedCoin!.constraints)
                    MatchViewController.reverseMap[killedCoin!]?.constraintLst[2].constant = 30
                    
                    
                    MatchViewController.reverseMap[killedCoin!]?.constraintLst[3].constant = 30
                    
                    killedCoin?.removeFromSuperview()
                    killedCoin?.contentMode = .scaleAspectFit
                    
                    killedCoin?.backgroundColor = .red
                    self.view.setNeedsLayout()
                    print(" SIZE SIZE SIZE ", killedCoin!.constraints, killedCoin?.frame)
                    self.myLCoins.addArrangedSubview(killedCoin!)
                }
            }
            
            
        }
    }
    
    func receive(){
           /// This Recurring will keep us connected to the server
           /*
            - Create a workItem
            - Add it to the Queue
            */
        print(" rcv function: ")
           let workItem = DispatchWorkItem{ [weak self] in
               print(" dispatchworkitem ")
               self!.ws!.receive(completionHandler: { result in
                   print(" attempting to read ")
                   switch result {
                   case .success(let message):
                       
                       switch message {
                       
                       case .data(let data):
                           print("Data received \(data)")
                          
                           
                           
                       case .string(let strMessgae):
                       print("String received \(strMessgae)")
                           let dec = JSONDecoder()
                           if let res: msgModel = try? dec.decode(msgModel.self, from: strMessgae.data(using:.utf8)!){
                               print(res.type)
                               print(res.src)
                               MatchViewController.matchSession.myComp.name = res.dest
                               MatchViewController.matchSession.oppComp.name = res.src
                               print(res.timingOption?.type)
                               print(" sending data  ......")
                               if(res.type == "requestInit"){ self!.send()}
                               else {
                                   print(res.coinMoved)
                                   self!.processReq(res)
                               }
                                    
                           }
                           
                       default:
                           break
                       }
                   
                   case .failure(let error):
                       print("Error Receiving \(error)")
                   }
                   // Creates the Recurrsion
                   self!.receive()
                 
               })
               
           }
           DispatchQueue.global().asyncAfter(deadline: .now() + 1 , execute: workItem)
       
       }
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol:String?){
        print(" connected ")
        receive()
        
    }
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
           print("Disconnect from Server \(reason)")
    }
    
    func setupView(){
        
        // -- websocket ------------
        
        
        connection.getConnection()?.setHandler(.play, processReq)
        
        MatchViewController.matchSession.oppComp.myCoin = "white"
        let uses = URLSession(configuration:.default, delegate: self, delegateQueue: nil)
        let url = URL(string: "wss://6ph3c75vv0.execute-api.us-east-1.amazonaws.com/production/")
        ws = uses.webSocketTask(with: url!)
//        ws!.resume()
        
        
        
        
        
        
        /// ------------------------
        
        
        moveHistory.backgroundColor = utils.moveHistColor
        moveHistory.tintColor = .white
        self.boardImg.contentMode = .scaleAspectFill
        let ar = self.boardImg.image!.size.height / self.boardImg.image!.size.width
        self.view.backgroundColor = utils.viewBG
        utils.activate([
            self.boardImg.widthAnchor.constraint(equalTo: self.view.widthAnchor ) ,
            self.boardImg.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: ar)
        ])
        self.view.layoutIfNeeded()
        initCoins2()
        utils.nomask([myIcon,oppIcon])
        oppNMyInfo(oppStk, oppIcon, oppName)
        oppNMyInfo(myStk, myIcon, myName)
        
        setupClk(self.oppClkStk, self.oppClkIcon, self.oppClock)
        setupClk(self.myClkStk, self.myClkIcon, self.myClk)
        
        MatchViewController.boardBounds!["left"] = self.boardView.frame.minX
        MatchViewController.boardBounds!["top"] = self.boardView.frame.minY
        MatchViewController.boardBounds!["width"] = self.boardView.frame.width
        MatchViewController.boardBounds!["height"] = self.boardView.frame.height
        MatchViewController.boardBounds!["bottom"] = self.boardView.frame.height + self.boardView.frame.minY
        MatchViewController.boardBounds!["right"] = self.boardView.frame.width + self.boardView.frame.minX
        
        
        // --- setting up notification
//        var nib = UINib(nibName: "custview", bundle: Bundle(for: type(of: self)))
//        nib.instantiate(withOwner: self)
//        
//        self.view.addSubview(popup)
//        
//        utils.nomask(popup)
//    
//        
//        
//        
//        
//        
//        let params = [
////            popup.topAnchor.constraint(equalTo: self.view.topAnchor),
//            popup.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            popup.widthAnchor.constraint(equalTo: self.view.widthAnchor),
//            popup.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -100)
//
//        ]
//        utils.activate(params)
//        popup.backgroundColor = .red
//    
//        DispatchQueue.main.asyncAfter(deadline: .now() , execute: {
//            print(" dq item execution ")
//            UIView.animate(withDuration: 0.5, delay: 0, animations: {
//                params[2].constant = 0
//                self.view.layoutIfNeeded()
//            })
//            
//            DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
//                UIView.animate(withDuration: 0.5, delay: 0, animations: {
//                    params[2].constant = -100
//                    self.view.layoutIfNeeded()
//                })
//            })
//        })
//
//        
        
        
        
        ///-------------------------
        
    }
    
    func setupClk(_ stk:UIStackView!, _ icon:UIImageView!, _ time:UILabel!){
        
        stk.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        stk.isLayoutMarginsRelativeArrangement = true
        stk.backgroundColor = utils.barColor
        stk.alignment = .fill
        time.textColor = .white
        icon.tintColor = .white
        utils.activate([time.widthAnchor.constraint(equalToConstant: 50),
                        
                        icon.widthAnchor.constraint(equalToConstant: 30)
                        
                        ])
         
    }
    
    func oppNMyInfo(_ stk:UIStackView!, _ icon:UIImageView!, _ name: UILabel!){
        
        self.myName.text = MatchViewController.matchSession.myComp.name
        self.oppName.text = MatchViewController.matchSession.oppComp.name
        stk.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        stk.isLayoutMarginsRelativeArrangement = true
        name.textColor = .white
        utils.nomask([stk])
        utils.activate([icon.widthAnchor.constraint(equalToConstant: 30),
                  icon.heightAnchor.constraint(equalToConstant: 30),
                        stk.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                        stk.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
                        
                       ])
    }
    
    @IBOutlet weak var myStk: UIStackView!
    @IBOutlet weak var oppStk: UIStackView!
    func initCoins(){
//        self.constraints = Dictionary<UIButton,[NSLayoutConstraint]>()
//        let bc = [
//            [br1,bh1,bb1,bq,bk,bb2,bh2,br2],
//            [bp1,bp2,bp3,bp4,bp5,bp6,bp7,bp8]
//        ]
//        let wc = [
//            [wp1,wp2,wp3,wp4,wp5,wp6,wp7,wp8],
//            [wr1,wh1,wb1,wq,wk,wb2,wh2,wr2]
//            
//        ]
//        let w = self.boardView.frame.width / 8
//        let h = self.boardView.frame.height / 8
//        br1.contentMode = .scaleToFill
//        br1.layer.borderColor = UIColor.red.cgColor
//        br1.layer.borderWidth = 5
//        print(" w is \(w) & \(self.boardImg.widthAnchor) \(self.boardView.frame.width)")
////        utils.nomask(br1)
////        utils.activate([
////
////            br1.topAnchor.constraint(equalTo: self.boardView.topAnchor),
////            br1.leadingAnchor.constraint(equalTo: self.boardView.leadingAnchor),
////        ])
////        utils.nomask(br1)
////        utils.activate([br1!.widthAnchor.constraint(equalToConstant: w),
////        br1.heightAnchor.constraint(equalToConstant: h)])
//        var yOffset = 0.0
//        for j in bc {
//            var xOffset = 0.0
//            
//            
//            for i in j{
//                var bounds = [ i!.leadingAnchor.constraint(equalTo: self.boardView.leadingAnchor, constant: xOffset * w),
//                    i!.topAnchor.constraint(equalTo: self.boardView.topAnchor, constant: yOffset * h)]
//                constraints![i!] = bounds
//                
//                utils.nomask(i!)
//                utils.activate([i!.widthAnchor.constraint(equalToConstant: w ),
//                                i!.heightAnchor.constraint(equalToConstant: h )
//                                
//                               ])
//                utils.activate(bounds)
//                xOffset = xOffset + 1
//            }
//            yOffset = yOffset + 1
//            
//        }
//        yOffset = 6
//        for j in wc {
//            var xOffset = 0.0
//            
//            
//            for i in j{
//                
//                var bounds = [ i!.leadingAnchor.constraint(equalTo: self.boardView.leadingAnchor, constant: xOffset * w),
//                               i!.topAnchor.constraint(equalTo: self.boardView.topAnchor, constant: yOffset * h )]
//                utils.nomask(i!)
//                utils.activate([i!.widthAnchor.constraint(equalToConstant: w ),
//                                i!.heightAnchor.constraint(equalToConstant: h ),
//                               ])
//                constraints![i!] = bounds
//                utils.activate(bounds)
//                xOffset = xOffset + 1
//            }
//            yOffset = yOffset + 1
//            
//        }
//       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        setupView()
//        boardView = chessBoardView()
        setupInit()
        swap()
        
        startGame()
        initCoins2()
//        self.view.setNeedsLayout()
//        self.view.setNeedsDisplay()
    }
   
    func setupInit(){
        if ( MatchViewController.matchSession.myComp.myCoin == "black"){
            mapping = [
                "1a" : coinInfo("wr1", wr1,"1a" , "1a", "white"),
                "1b" : coinInfo("wh1", wh1, "1b" , "1b", "white"),
                "1c" : coinInfo("wb1", wb1, "1c" , "1c", "white"),
                "1d" : coinInfo("wq", wq, "1d" , "1d", "white"),
                "1e" : coinInfo("wk", wk, "1e" , "1e", "white"),
                "1f" : coinInfo("wb2", wb2, "1f" , "1f", "white"),
                "1g" : coinInfo("wh2", wh2, "1g" , "1g", "white"),
                "1h" : coinInfo("wr2", wr2, "1h" , "1h", "white"),
                "2a" : coinInfo("wp1", wp1, "2a" , "2a", "white"),
                "2b" : coinInfo("wp2", wp2 , "2b" , "2b", "white"),
                "2c" : coinInfo("wp3", wp3, "2c" , "2c", "white"),
                "2d" : coinInfo("wp4", wp4, "2d" , "2d", "white"),
                "2e" : coinInfo("wp5", wp5, "2e" , "2e", "white"),
                "2f" : coinInfo("wp6", wp6, "2f" , "2f", "white"),
                "2g" : coinInfo("wp7", wp7, "2g" , "2g", "white"),
                "2h" : coinInfo("wp8", wp8, "2h" , "2h", "white"),
                "8a" : coinInfo("br1", br1, "8a"    , "8a", "black"),
                "8b" : coinInfo("bh1", bh1, "8b"    , "8b", "black"),
                "8c" : coinInfo("wb1", bb1, "8c"    , "8c", "black"),
                "8d" : coinInfo("bq", bq, "8d"    , "8d", "black"),
                "8e" : coinInfo("bk", bk, "8e"    , "8e", "black"),
                "8f" : coinInfo("bb2", bb2, "8f"    , "8f", "black"),
                "8g" : coinInfo("bh2", bh2, "8g"    , "8g", "black"),
                "8h" : coinInfo("br2", br2, "8h"    , "8h", "black"),
                "7a" : coinInfo("bp1", bp1, "7a"    , "7a", "black"),
                "7b" : coinInfo("bp2", bp2, "7b"    , "7b", "black"),
                "7c" : coinInfo("bp3", bp3, "7c"    , "7c", "black"),
                "7d" : coinInfo("bp4", bp4, "7d"    , "7d", "black"),
                "7e" : coinInfo("bp5", bp5, "7e"    , "7e", "black"),
                "7f" : coinInfo("bp6", bp6, "7f"    , "7f", "black"),
                "7g" : coinInfo("bp7", bp7, "7g"    , "7g", "black"),
                "7h" : coinInfo("bp8", bp8, "7h"    , "7h", "black"),
            ]
            MatchViewController.reverseMap = [
                wr1 :   mapping["1a"]!,
                wh1 :   mapping["1b"]!,
                wb1 :   mapping["1c"]!,
                wq :    mapping["1d"]!,
                wk :    mapping["1e"]!,
                wb2 :   mapping["1f"]!,
                wh2 :   mapping["1g"]!,
                wr2 :   mapping["1h"]!,
                wp1 :   mapping["2a"]!,
                wp2 :   mapping["2b"]!,
                wp3 :   mapping["2c"]!,
                wp4 :   mapping["2d"]!,
                wp5 :   mapping["2e"]!,
                wp6 :   mapping["2f"]!,
                wp7 :   mapping["2g"]!,
                wp8 :   mapping["2h"]!,
                br1 :   mapping["8a"]!,
                bh1 :   mapping["8b"]!,
                bb1 :   mapping["8c"]!,
                bq:    mapping["8d"]!,
                bk :    mapping["8e"]!,
                bb2 :   mapping["8f"]!,
                bh2 :   mapping["8g"]!,
                br2 :   mapping["8h"]!,
                bp1 :   mapping["7a"]!,
                bp2 :   mapping["7b"]!,
                bp3 :   mapping["7c"]!,
                bp4 :   mapping["7d"]!,
                bp5 :   mapping["7e"]!,
                bp6 :   mapping["7f"]!,
                bp7 :   mapping["7g"]!,
                bp8 :   mapping["7h"]!,
            ]
            
            
        }
        
        else {
            
            
        }
    }
    var myTimer:Timer? = nil
    func startGame() {
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateMyTime), userInfo: nil, repeats: true)
    }
    var count = 5
    
    func initCoins2(){
        
//            self.constraints = Dictionary<UIButton,[NSLayoutConstraint]>()
            let w = self.boardView.frame.width / 8
            let h = self.boardView.frame.height / 8
        
        
        for (k,v) in mapping {
            
            var key: String = k as! String
            var val = v as! coinInfo
            var row = key.split(separator: "")[0]
            var col = key.split(separator: "")[1]
            var bRc = val.name
            
            var btn = val.btn!
            
//            utils.activate([
//                btn.widthAnchor.constraint(equalToConstant: w),
//                btn.heightAnchor.constraint(equalToConstant: h),
//            ])
//            
            var rowOffset = 0.0//CGFloat( MatchViewController.matchSession.myComp.myCoin == "white" ? (8 - Int(row)! ) :
            var colOffset = 0.0
            
                                     if(MatchViewController.matchSession.myComp.myCoin == "black" ) {
                
                //                if(bRc == "b")
                //{
                colOffset = CGFloat( -1 * Int(col.unicodeScalars.first!.value) + Int("h".unicodeScalars.first!.value ) )
                rowOffset = CGFloat(Int(row)! - 1 )
           // }
//                else
//                { }
//                    
                
            }
               
               else {
                 rowOffset = CGFloat(8 - Int(row)! )
                colOffset = CGFloat(  Int(col.unicodeScalars.first!.value) - Int("a".unicodeScalars.first!.value ) )
                //colOffset = CGFloat( Int("h".unicodeScalars.first!.value) - Int(col.unicodeScalars.first!.value ))
            }
            let bounds = [
                btn.leadingAnchor.constraint(equalTo: self.boardView.leadingAnchor, constant: colOffset * w),
                btn.topAnchor.constraint(equalTo: self.boardView.topAnchor, constant: rowOffset * h ),
                btn.widthAnchor.constraint(equalToConstant: w),
                btn.heightAnchor.constraint(equalToConstant: h)
            ]
            
            val.constraintLst =  bounds
            utils.nomask(btn)
            utils.activate(bounds)
            
        }
        
        // -- standing bishop for checking bk
        
//        MatchViewController.reverseMap[wp5]?.constraintLst[0].constant = 0
//        MatchViewController.reverseMap[wp5]?.constraintLst[1].constant =  h * 4
        
        
        
            
        
    }
    static var skip:UIButton?
    @objc func updateMyTime(_ timer: Timer) {
        
//        print(" timer \(timer)")
        self.count = self.count - 1
        var ss = MatchViewController.matchSession.myComp.clkComp.ss
        var mm = MatchViewController.matchSession.myComp.clkComp.mm
        
            
        ss = ss - 1
        
        if( mm == 0 && ss == 0) {
            myTimer?.invalidate()
        }
        else if (ss == -1){
        
            ss = 59
            mm = mm - 1
        }
        
        if ( ss == 59 && mm == 0) {
            myClkIcon.image = UIImage(systemName: "clock")
        }
        
        
        myClkIcon.transform = CGAffineTransformMakeRotation(CGFloat(45 * rotCount))
        rotCount = (rotCount + 1 ) % 7
        MatchViewController.matchSession.myComp.clkComp.mm = mm
        MatchViewController.matchSession.myComp.clkComp.ss = ss
        var mmStr = String(format: "%02d",mm)
        var ssStr = String(format: "%02d",ss)
        myClk.text = "\(mmStr):\(ssStr)"
      
        
        
     
    }
    var rotCount:Int = 1
    class rotationSeq {
        static var rotationSequence = [UIImage.Orientation.up, UIImage.Orientation.right, UIImage.Orientation.down, UIImage.Orientation.left]
        static var curPos = 0
        static func next() -> UIImage.Orientation {
            let res = rotationSequence[curPos]
            curPos = (curPos + 1) % 4
            return res
        }
    }
  
}


class coinInfo {
    
    var position:String
    var btn:UIButton!
    var name:String!
    var boxId:String!
    var constraintLst:[NSLayoutConstraint] = []
    var type:String!
    init(_ nameIn:String, _ btnIn:UIButton!, _ posIn:String!, _ boxIdIn:String, _ typeIn:String){
        position = posIn
        btn = btnIn
        name = nameIn
        boxId = boxIdIn
        type = typeIn
    }
}
