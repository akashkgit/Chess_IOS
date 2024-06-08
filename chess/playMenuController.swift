//
//  playMenuControllerViewController.swift
//  chess
//
//  Created by akash kumar on 5/28/24.
//

import UIKit

class playMenuController: UIViewController {

    
    
    @IBOutlet weak var computer: UIButton!
    @IBOutlet weak var playFriend: UIButton!
    @IBOutlet weak var tournaments: UIButton!
    @IBOutlet weak var startGame: UIButton!
    @IBOutlet weak var timingOptions: UIButton!
    @IBOutlet weak var stkView: UIStackView!
    @objc func poper()->Void{
        print(" popped ")
    }
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
        title.text = "Play"
        title.tintColor = .white
        title.font = UIFont(name: "Impact", size: 30)
        self.navigationItem.titleView = title
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configNav()
        configButtons()
        self.view.backgroundColor = utils.viewBG
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.backgroundColor = utils.barColor
    
       
//        utils.nomask(popup)
        utils.nomask([stkView,computer,playFriend, tournaments, startGame, timingOptions, stkView])
//        let params = [
////            popup.topAnchor.constraint(equalTo: self.view.topAnchor),
//            popup.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            popup.widthAnchor.constraint(equalTo: self.view.widthAnchor),
//            popup.topAnchor.constraint(equalTo: stkView.topAnchor, constant: -200)
//            
//        ]
//        utils.activate(params)
//        popup.backgroundColor = .red
        computer.backgroundColor = .red
        stkView.backgroundColor = .blue
//        DispatchQueue.main.asyncAfter(deadline: .now() , execute: {
//            UIView.animate(withDuration: 0.5, delay: 0, animations: {
//                params[2].constant = self.popup.frame.height * -1 - 50
//                self.view.layoutIfNeeded()
//            })
//        })

        
    }
    
func configButtons() {

        timingOptions.backgroundColor = utils.btnColor
        tournaments.backgroundColor = utils.btnColor
        playFriend.backgroundColor = utils.btnColor
        computer.backgroundColor = utils.btnColor
        startGame.backgroundColor = utils.primGreen
        stkView.tintColor = .white
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
