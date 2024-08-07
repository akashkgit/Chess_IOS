//
//  tabmenu.swift
//  chess
//
//  Created by akash kumar on 5/27/24.
//

import Foundation
import UIKit


class tabMenuController : UITabBarController {
//    
//    @IBOutlet weak var sender: UILabel!
//    @IBOutlet var popup: UIView!
//    
//    
//    @IBAction func rejectReq(_ sender: Any) {
//        print(" rejecting  the request ")
//    }
//    
//
//    @IBAction func acceptReq(_ sender: Any) {
//        print(" accepting the request ")
//        //connection.getConnection()?.send()
//        
//    }
//    
//    @IBOutlet weak var stuck: UIStackView!
//    @IBOutlet weak var popupStk: UIStackView!
//    @IBOutlet weak var accept: UIButton!
//    @IBOutlet weak var reject: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabs()
        connection.connect()
       
        
        var matchReq =  popup(frame: .zero)
        matchReq.backgroundColor = utils.barColor
        self.view.addSubview(matchReq)
        utils.nomask(matchReq)
        
//
//        popupStk.clipsToBounds = true
        let params = [
//            popup.topAnchor.constraint(equalTo: self.view.topAnchor),
            matchReq.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            matchReq.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            matchReq.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -500)
            

        ]
        
        matchReq.rejectCB = {
            
            UIView.animate(withDuration: 0.5, delay: 0, animations: {
                
                params[2].constant = -500
                          self.view.layoutIfNeeded()
                print(" cganging to -500 \(matchReq.constraints)")
                      })
          
            
        }
        matchReq.acceptCB = {
            connection.getConnection()?.send()
            UIView.animate(withDuration: 0.5, delay: 0, animations: {
                          params[2].constant = -500
                print(" cganging to -500 \(matchReq.constraints)")
                          self.view.layoutIfNeeded()
                      })
            
            let sb = UIStoryboard.init(name: "Main", bundle: nil)
            let secondViewController = sb.instantiateViewController(withIdentifier: "matchView") as! MatchViewController
                let nextVc = secondViewController
            MatchViewController.matchSession.oppComp.name = matchReq.senderName.text
            MatchViewController.matchSession.myComp.name = userdata.username
            var vc:UINavigationController = self.viewControllers![0] as! UINavigationController//.pushViewController(nextVc, animated: true)
                vc.pushViewController(nextVc, animated: true)
            
        }
        utils.activate(params)
        
//    
//        
//        var c = utils.navColor.withAlphaComponent(1)
////        popupStk.backgroundColor = c
//        popupStk.backgroundColor = c
//        DispatchQueue.main.asyncAfter(deadline: .now() , execute: {
//            print(" dq item execution ")
//            //            self.sender.text = data.src
//            UIView.animate(withDuration: 0.5, delay: 0, animations: {
//                params[2].constant = 100
//                self.view.layoutIfNeeded()
//            })
//        })
        connection.getConnection()?.setHandler(.requestInit) {
        message in
            print("##### requestinit handler #########")
            
//            connection.getConnection()?.send()
            var data = message as! msgModel
//            MatchViewController.matchSession.timingOption = data.timingOption
            
//            var timeStr = data.timingOption!.split(separator:" ")
            var  tf = timeFormat()
            tf.setSrc(data.timingOption!.option)
            MatchViewController.matchSession.timingOption = tf
            
            print("-t-\(tf)")
            print(" set time --> tik tik =----=----===> \(tf) \(MatchViewController.matchSession.timingOption )")
                DispatchQueue.main.asyncAfter(deadline: .now() , execute: {
                    print(" dq item execution ")
                    matchReq.senderName.text = data.src
                    UIView.animate(withDuration: 0.5, delay: 0, animations: {
                        params[2].constant = 0
                        self.view.layoutIfNeeded()
                    })
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
                        UIView.animate(withDuration: 0.5, delay: 0, animations: {
                            params[2].constant = -500
                            self.view.layoutIfNeeded()
                        })
                    })
                })
            return nil
        }
        
    }
    
    func configTabs(){
        
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let secondViewController = sb.instantiateViewController(withIdentifier: "homepage") as! homeViewController
            let nextVc = secondViewController
//        self.navigationController!.pushViewController(nextVc, animated: true)
        let vc1 = nextVc
        let vc2 = puzzleViewController()
        let vc3 = learnViewController()
        let vc4 = watchViewController()
        let vc5 = moreViewController()
        
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        let app = UITabBarAppearance()
        app.backgroundImage = .none
        
        app.backgroundColor = utils.barColor
//        UITabBar.appearance().isTranslucent = true
        
//        app.configureWithTransparentBackground()
//        let rect = CGRect(x:0,y:0,width:1,height:1)
        
        
        UITabBar.appearance().standardAppearance = app
        UITabBar.appearance().scrollEdgeAppearance = app 
//        UITabBar.appearance().barTintColor = UIColor(white: 0, alpha: 0.3)
        UITabBar.appearance().tintColor = UIColor(red: 129/255, green: 182/255, blue: 76/255, alpha: 1)
        
        
        vc1.tabBarItem.title = "home"
        vc1.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        vc2.tabBarItem.image = UIImage(systemName: "puzzlepiece.fill")
        vc2.tabBarItem.title = "puzzle"
        vc3.tabBarItem.image = UIImage(systemName: "graduationcap.fill")
        vc3.tabBarItem.title = "learn"
        vc4.tabBarItem.image = UIImage(systemName: "binoculars.fill")
        vc4.tabBarItem.title = "watch"
        vc5.tabBarItem.image = UIImage(systemName: "ellipsis")
        vc5.tabBarItem.title = "more"
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        let nav5 = UINavigationController(rootViewController: vc5)
        
        setViewControllers([nav1,nav2,nav3,nav4,nav5], animated: true)
        
    }
    
    
}



