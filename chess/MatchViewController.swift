//
//  MatchViewController.swift
//  chess
//
//  Created by akash kumar on 5/29/24.
//

import UIKit

struct matchState {
    var myCoin:String = "black"
    
}
class MatchViewController: UIViewController {
    
    
    @IBOutlet weak var boardImg: UIImageView!
    var matchSession = matchState()
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
    
    private var activeEl: UIButton? = nil
    private var constraints : Dictionary<UIButton?, [NSLayoutConstraint]>? = nil
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
        var t = coin1.frame.origin
        coin1.frame.origin = coin2.frame.origin
        coin2.frame.origin = t
        
        
    }
    
    func swap(){
        if (matchSession.myCoin != "white"){
            
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
            //check for possible killing
            
            var  sender_xc = constraints![sender]![0]
            var  sender_yc = constraints![sender]![1]
            var activeEl_xc = constraints![activeEl!]![0]
            var activeEl_yc = constraints![activeEl!]![1]
            activeEl_xc.constant = sender_xc.constant
            activeEl_yc.constant = sender_yc.constant
            sender.removeFromSuperview()
            activeEl = nil 
        }
        else {
            
            var btn = sender
            activeEl = btn
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
        print(" ended ")
        let loc = sender.location(in: self.boardView)
        print("location @ \(sender.location(in: self.boardView))")
        
        /// --- new location calculation
        let frm = activeEl?.frame
        let width = Int(frm!.width)
        let height = Int(frm!.height)
        let oldX = Int(frm!.minX)
        let oldY = Int(frm!.minY)
        
        let test = CGRect(x: oldX, y: oldY, width: 10, height: 10)
        let testpt = UIImageView(frame: test)
        testpt.backgroundColor = .blue
        
        self.boardView.addSubview(testpt)
        
        
        var dY = oldY - Int(loc.y)
        var dX = oldX - Int( loc.x)
        var newY:Int = oldY - (( Int((dY / height))) * height)
        if( dY > 0 ) {newY = newY - height}
//            if ( dY < 0 && abs(dY) >= height ) { newY = newY + height }
        var newX:Int =  oldX - (( Int(dX / width) ) * width)
        if ( dX > 0) {newX = newX - width}
        let rect = CGRect(x: newX, y: newY, width: 10, height: 10)
        let pt = UIImageView(frame: rect)
        pt.backgroundColor = .red
        
        self.boardView.addSubview(pt)
        print("ox:\(oldX) oy:\(oldY) w:\(width) h:\(height) lx:\(loc.x) ly:\(loc.y) dy:\(dY) dx:\(dX) dy/h:\(dY/height)y: \((( (dY / height) + 1) * height)) /x: \((( (dX / width) ) * width)) ny: \(newY) nx:\(newX)")
//        activeEl?.frame = CGRect(x: CGFloat(newX) , y: CGFloat(newY), width: CGFloat(frm!.width), height: CGFloat(frm!.height))
        
        var xc = constraints![activeEl!]![0]
        var yc = constraints![activeEl!]![1]
        xc.constant = CGFloat(newX)
        yc.constant = CGFloat(newY)
        
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
    func setupView(){
        moveHistory.backgroundColor = utils.moveHistColor
        moveHistory.tintColor = .white
        self.boardImg.contentMode = .scaleAspectFill
        let ar = self.boardImg.image!.size.height / self.boardImg.image!.size.width
        
        utils.activate([
            self.boardImg.widthAnchor.constraint(equalTo: self.view.widthAnchor ) ,
            self.boardImg.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: ar)
        ])
        self.view.layoutIfNeeded()
        initCoins()
    }
    
    func initCoins(){
        self.constraints = Dictionary<UIButton,[NSLayoutConstraint]>()
        let bc = [
            [br1,bh1,bb1,bq,bk,bb2,bh2,br2],
            [bp1,bp2,bp3,bp4,bp5,bp6,bp7,bp8]
        ]
        let wc = [
            [wp1,wp2,wp3,wp4,wp5,wp6,wp7,wp8],
            [wr1,wh1,wb1,wq,wk,wb2,wh2,wr2]
            
        ]
        let w = self.boardView.frame.width / 8
        let h = self.boardView.frame.height / 8
        br1.contentMode = .scaleToFill
        br1.layer.borderColor = UIColor.red.cgColor
        br1.layer.borderWidth = 5
        print(" w is \(w) & \(self.boardImg.widthAnchor) \(self.boardView.frame.width)")
//        utils.nomask(br1)
//        utils.activate([
//        
//            br1.topAnchor.constraint(equalTo: self.boardView.topAnchor),
//            br1.leadingAnchor.constraint(equalTo: self.boardView.leadingAnchor),
//        ])
//        utils.nomask(br1)
//        utils.activate([br1!.widthAnchor.constraint(equalToConstant: w),
//        br1.heightAnchor.constraint(equalToConstant: h)])
        var yOffset = 0.0
        for j in bc {
            var xOffset = 0.0
            
            
            for i in j{
                var bounds = [ i!.leadingAnchor.constraint(equalTo: self.boardView.leadingAnchor, constant: xOffset * w),
                    i!.topAnchor.constraint(equalTo: self.boardView.topAnchor, constant: yOffset * h)]
                constraints![i!] = bounds
                
                utils.nomask(i!)
                utils.activate([i!.widthAnchor.constraint(equalToConstant: w ),
                                i!.heightAnchor.constraint(equalToConstant: h )
                                
                               ])
                utils.activate(bounds)
                xOffset = xOffset + 1
            }
            yOffset = yOffset + 1
            
        }
        yOffset = 6
        for j in wc {
            var xOffset = 0.0
            
            
            for i in j{
                
                var bounds = [ i!.leadingAnchor.constraint(equalTo: self.boardView.leadingAnchor, constant: xOffset * w),
                               i!.topAnchor.constraint(equalTo: self.boardView.topAnchor, constant: yOffset * h )]
                utils.nomask(i!)
                utils.activate([i!.widthAnchor.constraint(equalToConstant: w ),
                                i!.heightAnchor.constraint(equalToConstant: h ),
                               ])
                constraints![i!] = bounds
                utils.activate(bounds)
                xOffset = xOffset + 1
            }
            yOffset = yOffset + 1
            
        }
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        setupView()
//        boardView = chessBoardView()
        swap()
//        initCoins()
//        self.view.setNeedsLayout()
//        self.view.setNeedsDisplay()
    }
    
  
}
