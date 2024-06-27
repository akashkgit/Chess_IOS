//
//  homeItem.swift
//  chess
//
//  Created by akash kumar on 6/26/24.
//

import UIKit
@IBDesignable 
class homeItem: UIView {

    @IBOutlet weak var subImg: UIImageView!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet var rootview: UIView!
    /*
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
    
    @IBOutlet weak var senderIcon: UIImageView!
    private func commonInit(){
        
        let bundle  = Bundle(for: type(of:self))
        let nib = UINib(nibName: "homeItem", bundle: bundle)
        let frst = nib.instantiate(withOwner: self, options: nil ).first as! UIView
        print("custom xib ")
        frst.backgroundColor = utils.moveHistColor
        self.frame = frst.bounds
//
//        senderName.textColor = .gray
        self.addSubview(frst)
        self.rootview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
      
    }
}
