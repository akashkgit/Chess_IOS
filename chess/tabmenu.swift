//
//  tabmenu.swift
//  chess
//
//  Created by akash kumar on 5/27/24.
//

import Foundation
import UIKit


class tabMenuController : UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabs()
    }
    
    func configTabs(){
        let vc1 = homeViewController()
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



