//
//  friendCard.swift
//  chess
//
//  Created by akash kumar on 6/21/24.
//

import UIKit

class friendCard: UIView {

    @IBOutlet weak var playerScore: UILabel!
    
    @IBOutlet var rootview: UIView!
    @IBOutlet weak var playerId: UILabel!
    @IBOutlet weak var playerStatus: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var detailsStack: UIStackView!
    @IBOutlet weak var stkView: UIStackView!
    @IBOutlet weak var icon: UIImageView!
    
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
        let nib = UINib(nibName: "userCard", bundle: bundle)
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
