//
//  popup.swift
//  chess
//
//  Created by akash kumar on 6/7/24.
//

import UIKit
@IBDesignable
class popup: UIView {

    
    @IBOutlet weak var senderName: UILabel!
    @IBOutlet var rootview: UIView!
    typealias fnCB = () -> Void
    var acceptCB: fnCB?
    var rejectCB: fnCB?
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
        let nib = UINib(nibName: "pop", bundle: bundle)
        let frst = nib.instantiate(withOwner: self, options: nil ).first as! UIView
        print("custom xib ")
        frst.backgroundColor = .green
        self.frame = frst.bounds
//
        self.addSubview(frst)
        rootview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
      
    }
    
    @IBAction func accept(_ sender: Any) {
        acceptCB!()
        print("Accepted ")
        
    }
    
    @IBAction func reject(_ sender: Any) {
        rejectCB!()
        print("rejected")
    }
}
