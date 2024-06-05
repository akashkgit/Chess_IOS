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


struct msg: Codable {
    var action:String?
    var type:String?
    var choice:String?
    var src:String?
    var dest:String?
    var coinMoved:move?
    var timingOption: timeFormat?
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
