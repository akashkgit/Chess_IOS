//
//  statBox.swift
//  chess
//
//  Created by akash kumar on 6/26/24.
//

import UIKit
//@IBDesignable
class statBoxCls: UIView {
    @IBOutlet weak var outerStk: UIStackView!
    @IBOutlet var rootview: statBoxCls!
    
    @IBOutlet weak var icon: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    /*
     @IBOutlet weak var img: UIImageView!
     // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect){
        super.init(frame:frame)
        print(" called ")
        self.commonInit()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        self.commonInit()
    }
    
    
    private func commonInit(){
        
        let bundle  = Bundle(for: type(of:self))
        let nib = UINib(nibName: "statBox", bundle: bundle)
        let frst = nib.instantiate(withOwner: self, options: nil ).first as! UIView
        print("custom xib 2")
        frst.backgroundColor = utils.moveHistColor
        self.frame = frst.bounds
//
//        senderName.textColor = .gray
        self.addSubview(frst)
        self.rootview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
        outerStk.backgroundColor = utils.barColor
        title.textColor = .gray
        score.textColor = .white 
      
    }
}
