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
    var type:String
    var option:String
}


struct msgModel: Codable {
    var action:String?
    var type:String?
    var choice:String?
    var src:String?
    var dest:String?
    var authorized:Bool?
    var coinMoved:move?
    var timingOption: timeFormat?
    var jwt:String?
    var chatMsg:String?
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
