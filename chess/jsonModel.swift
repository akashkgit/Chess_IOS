//
//  jsonModel.swift
//  chess
//
//  Created by akash kumar on 6/2/24.
//

import Foundation


struct json:Codable {
    
    var type:String
    var src:String
    var timingOption:timeFormat
    
}


struct timeFormat: Codable {
    var mm:String?
    var ss:String?
    var src:String?
    
    mutating func setSrc(_ srcIn:String){
        src = srcIn
        var str = src!.split(separator:" ")
        if str[1].lowercased() == "min"  {
            
            self.mm  = String(format:"%02d", Int((str[0]))!)
            print("-t-m-\(String(str[0]))-\(self.mm)")
            self.ss = "00"
        }
        else if str[1].lowercased() == "sec" {
            self.mm = "00"
            self.ss  = String(format:"%02d", Int((str[0]))!)
        }
        else {
            print("-NAT-")
        }
        
        
    }
}

struct requestInit: Codable {
    var action:String?
    var src:String?
    var dest:String?
    var timingOption: String?
}

struct msgModel: Codable {
    var action:String?
    var type:String?
    var choice:String?
    var src:String?
    var dest:String?
    var authorized:Bool?
//    var timingOption:String?
    var coinMoved:move?
    var timingOption: gameTime?
    var jwt:String?
    var startsWith:String?
    var friendList:[[String:String]]?
    var chatMsg:String?
}

struct gameTime:Codable {
    var type:String
    var option:String
}

struct move: Codable {
var coin: Coin
var Pos:[Int]
    var kill: killer?
    var check :Bool
}
struct Coin : Codable{
var type: String
var boxId:String
var curPos:String
}

struct killer: Codable{
    
    var kill:Bool?
    var dataPos:String?
}
//
//"{\"action\":\"matchManager\",\"type\":\"play\",\"coinMoved\":{\"coin\":{\"type\":\"p\",\"boxId\":\"2e\",\"curPos\":\"x5d\"},\"Pos\":[-1,-1],\"kill\":{\"kill\":true,\"dataPos\":\"7d\"},\"check\":fal
