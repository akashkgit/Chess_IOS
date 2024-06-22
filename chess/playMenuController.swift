//
//  playMenuControllerViewController.swift
//  chess
//
//  Created by akash kumar on 5/28/24.
//

import UIKit

class playMenuController: UIViewController {
    
    
    
//    @objc func poper()->Void{
//        print(" popped ")
//    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        print(" tapped ")
        self.navigationController?.popViewController(animated: true)
        
        // Your action
    }
    @objc func next(tapGestureRecognizer: UITapGestureRecognizer)
    {
        performSegue(withIdentifier: "playAFriend", sender: self)
        
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
        title.text = "Play"
        title.tintColor = .white
        title.textColor = .white
        title.font = UIFont(name: "Gill Sans", size: 30)
        self.navigationItem.titleView = title
        
        
        let goTo = UITapGestureRecognizer(target: self, action: #selector(next(tapGestureRecognizer:)))
        
         self.friendStack.addGestureRecognizer(goTo)
        
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        configButtons()
      
        
    }
    
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var friendStack: UIStackView!
    @IBOutlet weak var oneMinS: UIStackView!
    @IBOutlet weak var startGame: UIStackView!
    @IBOutlet weak var computerStack: UIStackView!
    var lst:[UIView]?
    
   
    @IBOutlet weak var tournaments: UIStackView!
    
    func configButtons() {
        
        lst =  [friendStack, startBtn, tournaments, oneMinS, computerStack]
        self.view.backgroundColor = utils.viewBG
        
        for i in lst! {
            var v = i as UIView
            v.layer.cornerRadius = 7
            
            if i != startBtn {
                i.backgroundColor = utils.barColor
                
            }
            else {
                i.backgroundColor = utils.primGreen
                
                
            }
            
        }
        
        
        
    }
}
