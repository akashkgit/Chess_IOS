//
//  playAFriend.swift
//  chess
//
//  Created by akash kumar on 5/29/24.
//

import UIKit

class playAFriend: UIViewController {

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
        title.font = UIFont(name: "Impact", size: 30)
        self.navigationItem.titleView = title
      
    }
    func setupView(){
        self.view.backgroundColor = utils.viewBG
        play.addTarget(self, action: #selector(playFn), for: .touchUpInside)
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
