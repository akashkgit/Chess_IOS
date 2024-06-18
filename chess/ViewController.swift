//
//  ViewController.swift
//  chess
//
//  Created by akash kumar on 5/16/24.
//

import UIKit

class homeViewController: UIViewController {

   
    private var item = scrollItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //configNav();
//^.*.blue$
        view.backgroundColor = UIColor(red: 46/255, green: 44/255, blue: 41/255, alpha: 1)
        
     
        
    }
    
    func auth(){
        
        connection.getConnection()?.setHandler(.auth, {
            data in
            var d = data as! msgModel
            if(d.authorized!){
                userdata.login = true
                
            }
            else { userdata.login = false }
            return nil
        })
        let uname = UserDefaults.standard.string(    forKey: "username")
        let jwt = UserDefaults.standard.string(    forKey: "jwt")
        let login = UserDefaults.standard.bool(    forKey: "login")
        
        print(" auth check \(uname) \(jwt) \(login)")
        
        
        if(login){
            let ws = connection.getConnection()
            //{"action":"auth","jwt":localStorage.getItem("jwt")}
            var msg = msgModel(action: "auth", type: "", choice: "", src: "", dest: "", coinMoved: nil, jwt:jwt)
            ws?.send(msg)
            userdata.username = uname!
            MatchViewController.matchSession.myComp.name = uname!
            
        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNav()
        
        let menu = scrollMenu()
        
        
        menu.parentView = self.view
        
        item.build("mi", "solve 200+ Puzzles", "Rating: 200", "puzzle")
        let menuDetails = [
        ["mi", "solve 200+ Puzzles", "Rating: 200", "puzzle"],
        ["mi", "solve 200+ Puzzles", "Rating: 200", "puzzle"],
        ["mi", "solve 200+ Puzzles", "Rating: 200", "puzzle"],
        ["mi", "solve 200+ Puzzles", "Rating: 200", "puzzle"],
        ["mi", "solve 200+ Puzzles", "Rating: 200", "puzzle"],
        ["mi", "solve 200+ Puzzles", "Rating: 200", "puzzle"],
        ["mi", "solve 200+ Puzzles", "Rating: 200", "puzzle"]
        ]
        for i in menuDetails {
            var itm = scrollItem()
            itm.build(i[0],i[1],i[2],i[3])
            menu.addItem(items: itm)
        }
            
        
        
        
        menu.build()
        self.view.addSubview(menu)
        
        let addPlayBtn = {
            var stk = UIStackView()
            var btn = UIButton()
            stk.axis = .horizontal
            stk.alignment = .center
            stk.isLayoutMarginsRelativeArrangement = true
            //UIColor(red: 33/255, green: 31/255, blue: 30/255, alpha: 0.89)
            stk.backgroundColor =  utils.barColor
            stk.addArrangedSubview(btn)
            self.view.addSubview(stk)
            btn.backgroundColor = utils.primGreen
            btn.setTitle("Play", for: .normal)
            btn.tintColor = .gray
            btn.backgroundColor = utils.primGreen
            btn.layer.cornerRadius = 5
//            stk.backgroundColor = .yellow
            utils.nomask([stk,btn])
//            self.extendedLayoutIncludesOpaqueBars
            stk.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30)
            utils.activate([
                btn.widthAnchor.constraint(equalToConstant: 100),
//                            btn.centerXAnchor.constraint(equalTo:stk.centerXAnchor),
//                            btn.centerYAnchor.constraint(equalTo:stk.centerYAnchor),
//                            stk.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                            stk.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                            stk.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                            stk.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
                           ])
            
            btn.addTarget(self, action: #selector(self.playBtnClkd), for: .touchUpInside)
        }
        addPlayBtn()
//        self.view.addSubview(btn)
            auth()
    }
    
    @objc func playBtnClkd()->Void{
            print("clicked ")
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let secondViewController = sb.instantiateViewController(withIdentifier: "playMenuIB") as! playMenuController
            let nextVc = secondViewController
        self.navigationController!.pushViewController(nextVc, animated: true)
        
                
        
            
    }
    @objc func poper()-> Void {
        print(" popping ")
    }
    func configNav() -> Void {
        
        //print(" loaded ");
        
        let  navc = navigationController
        let navb = navc!.navigationBar
        let navi = navigationItem
        
        guard self.navigationController != nil else {
            
            //print(" no nav ")
            return
        }
//        self.navigationController?.navigationBar.barStyle = .default
        let app = UINavigationBarAppearance()
        
        app.backgroundColor = UIColor(red: 33/255, green: 31/255, blue: 30/255, alpha: 1)
        
        navigationController?.navigationBar.standardAppearance = app
//        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.compactAppearance = app
        navigationController?.navigationBar.scrollEdgeAppearance = app
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(poper))
        
        
        
        let v = UIImageView()
        v.image = UIImage(named:"clogo")
//        v.widthAnchor.constraint(equalToConstant: 55).isActive = true
        v.contentMode = .scaleAspectFit
        v.heightAnchor.constraint(equalToConstant: 40).isActive = true
        v.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        v.backgroundColor = .systemPink
        navigationItem.titleView = v


        v.translatesAutoresizingMaskIntoConstraints = false
//
        let social = UIImage(named: "social")
        let socialCon = UIImageView(image: social)
        socialCon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        socialCon.widthAnchor.constraint(equalToConstant: 30).isActive = true
//        socialCon.backgroundColor = .red
        
        let lbb2i = UIImage(named: "lbb1")
        let lbb2 = UIImageView(image: lbb2i)
        lbb2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        lbb2.widthAnchor.constraint(equalToConstant: 30).isActive = true
//        lbb2.backgroundColor = .red
        
        
        let lbl = UILabel()
        lbl.font = UIFont(name: "chessglyph-v3", size: 30)
        lbl.text = "\u{1FA5}"
        lbl.sizeToFit()
        lbl.textColor = .white
        
        
        lbl.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 350, leading: 10, bottom: 10, trailing: 10)
//^.*.blue$
        
        
        guard userdata.login == true else {
            
            let signupBtn = UIButton()
            signupBtn.setTitle( "Signup", for: .normal)
            signupBtn.addTarget(self, action:#selector(signin), for: .touchUpInside)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: signupBtn)
//            navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: lbb2 ), UIBarButtonItem(customView: lbl)]
//            socialCon.contentMode = .scaleAspectFit
//            socialCon.translatesAutoresizingMaskIntoConstraints = false
            utils.nomask(signupBtn)
            navb.topItem?.hidesBackButton = true
            
            return
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: socialCon)
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: lbb2 ), UIBarButtonItem(customView: lbl)]
        socialCon.contentMode = .scaleAspectFit
        socialCon.translatesAutoresizingMaskIntoConstraints = false
        navb.topItem?.hidesBackButton = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: socialCon)
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: lbb2 ), UIBarButtonItem(customView: lbl)]
        socialCon.contentMode = .scaleAspectFit
        socialCon.translatesAutoresizingMaskIntoConstraints = false
        navb.topItem?.hidesBackButton = true
        
        
//
        
        
//        navigationController?.navigationItem.titleView?.addSubview(v)
        
        
    }
    
    @IBAction func unwindedSingup(_ param:UIStoryboardSegue){
        
    }
    @objc func signin(){
        let sNav = self.navigationController!
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let secondViewController = sb.instantiateViewController(withIdentifier: "signup1") as! signupViewController
            let nextVc = secondViewController
        print(" singup button clicked ")
            sNav.pushViewController(nextVc, animated: true)
        print(" pushed ")
        
    }
   
}


struct utils {
    static let primGreen = UIColor(red: 129/255, green: 182/255, blue: 76/255, alpha: 1)
    static let barColor =  UIColor(red: 33/255, green: 31/255, blue: 30/255, alpha: 1 )
    static let viewBG = UIColor(red: 46/255, green: 44/255, blue: 41/255, alpha: 1)
    static let btnColor = UIColor(red: 46/255, green: 46/255, blue: 43/255, alpha: 1)
    static let navColor = UIColor(red: 33/255, green: 31/255, blue: 30/255, alpha: 1)
    static let chatBox = UIColor(red: 79/255, green: 77/255, blue: 76/255, alpha: 1)
    static let chatFontColor = UIColor(red: 222/255, green: 220/255, blue: 221/255, alpha: 1)
    static let moveHistColor = UIColor(red: 28/255, green: 26/255, blue: 25/255, alpha: 1)
    static func nomask(_ anyView: UIView) -> Void {
        anyView.translatesAutoresizingMaskIntoConstraints = false
    }
    static func nomask(_ anyView :[UIView]) -> Void {
        for i in anyView {
            i.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    static func activate(_ arr:[NSLayoutConstraint])->Void {
        
        for i in arr {
            i.isActive = true
        }
    }
}
struct scrollItem {
    
    var container:UIStackView!
    private var largeImg: UIImage?
    private var rightContainer:UIStackView?
    var title:String? = ""
    let titleView = UILabel()
    private var subTitle:String?
    private var font1 = UIFont(name: "Georgia", size: 16)
    private var font2 = UIFont(name: "noteworthy", size: 16)
    mutating func build(_ img: String, _ title:String, _ subTitle :String, _ subIcon:String){
        
        self.container = UIStackView()
        self.container.spacing = 40
     
        self.container.axis = .horizontal
        let imgv = UIImageView()
        imgv.image = UIImage(named: img)
        imgv.layer.borderWidth = CGFloat(3)
        imgv.layer.shadowColor = UIColor.white.cgColor
        imgv.layer.shadowOffset = CGSize(width: 10, height: 10)
        imgv.layer.cornerRadius = imgv.frame.size.width/2
        imgv.layer.masksToBounds = true
        imgv.layer.borderColor = UIColor.lightGray.cgColor
        utils.activate([imgv.widthAnchor.constraint(equalToConstant: 150), imgv.heightAnchor.constraint(equalToConstant: 150)])
        container.addArrangedSubview(imgv)
        
        let rightContainer = UIStackView()
        rightContainer.axis = .vertical
        rightContainer.alignment = .center
    
        
        titleView.text = title
        titleView.sizeToFit()
        titleView.font = self.font1
        titleView.lineBreakMode = .byClipping
        titleView.textColor = .gray
    
        let subTitleView = UILabel()
        subTitleView.text = subTitle
        subTitleView.sizeToFit()
        subTitleView.font = self.font2
        subTitleView.textColor = .gray
        subTitleView.lineBreakMode = .byClipping
        
        let subIconView  = UIImageView()
        subIconView.image = UIImage(named: subIcon)
        utils.activate([subIconView.widthAnchor.constraint(equalToConstant: 40), subIconView.heightAnchor.constraint(equalToConstant: 40)])
        
        rightContainer.addArrangedSubview(titleView)
        rightContainer.addArrangedSubview(subTitleView)
        rightContainer.addArrangedSubview(subIconView)
        container.addArrangedSubview(rightContainer)
        utils.nomask(imgv)
        utils.nomask(rightContainer)
        utils.nomask(titleView)
        utils.nomask(subTitleView)
        utils.nomask([subIconView,container])
        
        
    }
}
class scrollMenu : UIView{
    var  parentView: UIView = UIView()
    var itemsLst: [scrollItem]? = Array()
    private var scrollMenu: UIScrollView?
    
    func addItem(items item :scrollItem) -> Void {
        //print(" inside function ")
        
        guard itemsLst != nil else{
            //print(" nul errror itemslst ")
            return
        }
        itemsLst?.append(item)
        
    }
    
    
    func build()->Void {
        
        let scrollView = UIScrollView()
        let contentView = UIView()
        
//^.*.blue$
        contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 30, leading: 30, bottom: 30, trailing: 30)
        self.parentView.addSubview(scrollView)
        scrollView.addSubview(contentView)
//        let fl1 = itemsLst![0].container!
//        contentView.addSubview(fl1)
//
//^.*.blue$
        utils.nomask([scrollView,contentView])
        
        utils.activate([
            scrollView.topAnchor.constraint(equalTo: self.parentView.topAnchor),
            scrollView.heightAnchor.constraint(equalTo: self.parentView.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.parentView.widthAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.parentView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
          contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 2),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
        ])
        var prev: UIView? = nil
        for (id,i) in itemsLst!.enumerated(){
            contentView.addSubview(i.container)
//            i.container.backgroundColor = if(id % 2 == 0)
//            {.white } else {.black}
            if id == itemsLst!.count - 1  {
                utils.activate([
                    i.container.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
                    i.container.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
                    
                ])
            }
            else if var p = prev {
                utils.activate([
                    i.container.topAnchor.constraint(equalTo: prev!.layoutMarginsGuide.bottomAnchor, constant: 20),
                    i.container.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
                    
                ])
            }
            else{
                utils.activate([
                    i.container.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
                    i.container.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
                ])
            }
            prev = i.container
            
        }
        
    }
    
    
    
    
    
    
    
}

