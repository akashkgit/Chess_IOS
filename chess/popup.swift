//
//  popup.swift
//  chess
//
//  Created by akash kumar on 6/7/24.
//

import UIKit

class popup: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setView()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setView()
        }
    
    
    func setView() {
        var nib = Bundle.main.loadNibNamed("custview", owner: self, options: nil)
        
        
        
    }

}
