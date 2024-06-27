//
//  matchData.swift
//  chess
//
//  Created by akash kumar on 6/8/24.
//

import Foundation
typealias fn = (_ data:Any?) -> Any?
enum msgTypes{
    case requestInit
    case requestAck
    case play
    case chat
    case friendList
    case auth
    case connInit
    case defaults
    
}
class connection_ : NSObject, URLSessionWebSocketDelegate {
    
    
    var handlers:[msgTypes:fn] = [msgTypes:fn]()
    
    func setHandler( _ typeIn:msgTypes, _ handlerIn: @escaping  fn ){
        handlers[typeIn] = handlerIn
    }
    private var ws : URLSessionWebSocketTask? = nil
    func getWS() -> URLSessionWebSocketTask? {
        return ws
    }
    override init() {
        super.init()
        let uses = URLSession(configuration:.default, delegate: self, delegateQueue: nil)
        let url = URL(string: "wss://6ph3c75vv0.execute-api.us-east-1.amazonaws.com/production/")
        self.ws = uses.webSocketTask(with: url!)
        ws!.resume()
        
        
        
    }
    func receive(){
          
        print(" rcv function: ")
           let workItem = DispatchWorkItem{ [weak self] in
               print(" dispatchworkitem ")
               self!.ws!.receive(completionHandler: { result in
                   print(" attempting to read ")
                   switch result {
                   case .success(let message):
                       
                       switch message {
                       
                       case .data(let data):
                           print("Data received \(data)")
                          
                           
                           
                       case .string(let strMessgae):
                       print("String received \(strMessgae)")
                           let dec = JSONDecoder()
                           if let res: msgModel = try? dec.decode(msgModel.self, from: strMessgae.data(using:.utf8)!){
                               print(res.type)
                               print(res.src)
                               MatchViewController.matchSession.myComp.name = res.dest
                               MatchViewController.matchSession.oppComp.name = res.src
//                               print(res.timingOption?.type)
                               
                               switch (res.type){
                               case "requestInit" :
                                   print("case Request init ")
                                   self!.handlers[msgTypes.requestInit]!(res)
                               case "auth":
                                   print(" ((response \(res) ))\n\(res.type) \(res.authorized)")
                                   self!.handlers[msgTypes.auth]!(res)
                                   
                               case "chatMsg" :
                                   print(" calling chatmsg handler ")
                                   self!.handlers[msgTypes.chat]!(res)
                               case "requestAck":
                                   print(" request ack recieved")
                                   self!.handlers[msgTypes.requestAck]!(res)
                                   
                                   
                               default:
                                   
                                   if let f = res.friendList {
                                       self!.handlers[msgTypes.friendList]!(res)
                                   }
                                   
                                   if (res.action == "play"){
                                       self!.handlers[msgTypes.play]!(res)
                                   }
                               }
//                               if(res.type == "requestInit"){ self!.send()}
//                               else {
//                                   print(res.coinMoved)
//                                   self!.processReq(res)
//                               }
                                    
                           }
                           
                       default:
                           break
                       }
                   
                   case .failure(let error):
                       print("Error Receiving \(error)")
                   }
                   // Creates the Recurrsion
                   self!.receive()
                 
               })
               
           }
           DispatchQueue.global().asyncAfter(deadline: .now() + 1 , execute: workItem)
       
       }
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol:String?){
        print(" connected ")
        receive()
        
    }
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
           print("Disconnect from Server \(reason)")
    }
    
    func requestInit(_ data: requestInit ){
        //{ action: "matchManager", type: "requestAck", "choice": "accept", "src": src, "dest": localStorage.getItem("username") }
        // {"action":"matchManager","type":"play","coinMoved":{"coin":{"type":"p","boxId":"2e","curPos":"4e"},"Pos":[0,-2],"kill":{"kill":false},"check":false},"dest":"bib","src":"pip"}
        struct msg: Codable {
            var action:String
            var type:String
            var choice:String
            var src:String
            var dest:String
            var coinMoved:move?
            
            
        }
        
        struct move: Codable {
        var coin: Coin
        var Pos:[Int]
            var kill: [String:Bool]
            var check :Bool
        }
        struct Coin : Codable{
        var type: String
        var boxId:String
        var curPos:String
        }
        let jen = JSONEncoder()
        var res = try? jen.encode( data )
        let json = String(data:res!, encoding: String.Encoding.utf8)
        print(" sending data \(json)")
        ws!.send(URLSessionWebSocketTask.Message.string(json!)){
            error in
            print(" send result : \(error) !")
        }
    }
    
    func send(_ data: msgModel! = msgModel(action: "matchManager", type: "requestAck", choice: "accept", src: "pip", dest: "bib", coinMoved: nil) ){
        //{ action: "matchManager", type: "requestAck", "choice": "accept", "src": src, "dest": localStorage.getItem("username") }
        // {"action":"matchManager","type":"play","coinMoved":{"coin":{"type":"p","boxId":"2e","curPos":"4e"},"Pos":[0,-2],"kill":{"kill":false},"check":false},"dest":"bib","src":"pip"}
        struct msg: Codable {
            var action:String
            var type:String
            var choice:String
            var src:String
            var dest:String
            var coinMoved:move?
            
            
        }
        
        struct move: Codable {
        var coin: Coin
        var Pos:[Int]
            var kill: [String:Bool]
            var check :Bool
        }
        struct Coin : Codable{
        var type: String
        var boxId:String
        var curPos:String
        }
        let jen = JSONEncoder()
        var res = try? jen.encode( data )
        let json = String(data:res!, encoding: String.Encoding.utf8)
        print(" sending data \(json)")
        ws!.send(URLSessionWebSocketTask.Message.string(json!)){
            error in
            print(" send result : \(error) !")
        }
    }
    
    
}


class connection {
    static private var conn:connection_? = nil
    private init() {
        
    }
    static func connect(){
        connection.conn = connection_()
    }
    static func getConnection()->connection_?{
        if let c = conn {
            return c
        }
        else {
            return connection_()
        }
        
    }
}

struct urls {
    static var signup:String = "https://s38121vp76.execute-api.us-east-1.amazonaws.com/signup"
    
    static var login :String = "https://s38121vp76.execute-api.us-east-1.amazonaws.com/login"
}

struct userdata {
    static var username:String = ""
    static var login:Bool = false
    
}


struct loginResponse:Codable {
    var found:Bool!
    var jwt:String!
}
