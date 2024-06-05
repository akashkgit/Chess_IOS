//
//  chessMoves.swift
//  chess
//
//  Created by akash kumar on 6/3/24.
//

import Foundation
import UIKit

var moveMapping = [
    "p": pawn,
    "k": king,
    "q":queen,
    "b":bishop,
    "r":rook,
    "h":horse
]

enum status {
    case prohibited_inCorrentPattern
    case granted_killing
    case prohibited_obstructed
    case granted_plain
    
}


func pawn(_ btn:UIButton! ,_ update: [Int], _ dest:UIButton?) -> status {
  
    
    
    
    
    // trajectory check
    var  j = 1.0
    while( j <= 2) {
        print("\(btn.frame.minY) \( btn.frame.height) j:\(j) \(j *  btn.frame.height) for \(MatchViewController.reverseMap[btn]?.name)")
        var  blocRkil = match( btn.frame.minY -  j *  btn.frame.height , btn.frame.minX, dest)
        switch (blocRkil) {
        case let  x where x == status.prohibited_obstructed ||  x == status.granted_killing :
            print(" obs | kill 1")
            if (update[1] == Int(j) && 0   == update[0]){
                return status.prohibited_obstructed
            }
        
        default :
            
            if( j == 1.0 && Int(j) == update[1] && update[0] == 0){
                return status.granted_plain
            }
            else if ( j == 2.0 && MatchViewController.reverseMap[btn]!.position ==   MatchViewController.reverseMap[btn]!.boxId  && 2 == update[1] && update[0] == 0 ){
                return status.granted_plain
            }
            
            print("default 1 \(j) \(update[1]) \(update[0])")
        }
        j = j + 1
    }
//    j = 1
    for j in [-1.0,1.0] {
        var  blocRkil = match( btn.frame.minY - 1 *  btn.frame.height , btn.frame.minX + j * btn.frame.width, dest)
        switch (blocRkil) {
        case let  x where x == status.prohibited_obstructed || x == status.granted_killing :
            print("obs | kill 2 \(j) \(update[1]) \(update[0])")
            if( update[1] == 1 && update[0] == -1 * Int(j)) {
                return x
            }
            
        default :
            
            
            print(" default 2")
        }
     
    }
    
    return status.prohibited_inCorrentPattern
}

func match( _ y:CGFloat, _ x:CGFloat, _ dest:UIButton?)  -> status{
    
    for (k,v) in MatchViewController.reverseMap {
        var btn: UIButton = k as UIButton
        var coinInfo_ : coinInfo = v as coinInfo
        
        if(abs(btn.frame.minX - x) < btn.frame.width / 2 &&  abs(btn.frame.minY - y) < btn.frame.height / 2){
            if let d = dest, d == btn, MatchViewController.matchSession.myComp.myCoin != MatchViewController.reverseMap[d]!.type {
                print("kill \(btn.frame.minX)/ \(x) & \(btn.frame.minY)/\(y): \(coinInfo_.name)")
                return status.granted_killing
            }
            else {
                print("obstructed by  \(btn.frame.minX)/ \(x) & \(btn.frame.minY)/\(y): \(coinInfo_.name)")
                return status.prohibited_obstructed
            }
        }
        
    }
    return status.granted_plain
    
}

func queen(_ btn:UIButton! ,_ update: [Int], _ dest:UIButton?) -> status{
    
    
    var rk = rook(btn , update,  dest)
    if (rk == status.granted_killing || rk == status.granted_plain){
        return rk
    }
    var bshp = bishop(btn , update,  dest)
    return bshp
}
func horse(_ btn:UIButton! ,_ update: [Int], _ dest:UIButton?) -> status{
 
    
    
    var row_ = 2.0, col_ = 1.0, top_ = 0.0, left_ = 0.0, width = btn.frame.width, height = btn.frame.height
    
    top_ = btn.frame.minY
    left_ = btn.frame.minX
    
    
    print(" ## tr1 check ###")
    left_ = btn.frame.minX + width
    top_ = top_ - 2 * height
    
tr1: while( row_ <= 2 && top_ >= 0 && col_ <= 1 && left_ <= MatchViewController.boardBounds!["right"]!  && left_ >= -1 * width/2){
        
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where  x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == Int(row_) && update[0] == -1 * Int(col_) ){
                return x
            }
            
        case let  x where x == status.prohibited_obstructed :
            break tr1
        default :
            
            if( update[1] == Int(row_) && update[0] == -1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
        
        row_ = row_ + 1
        top_ = top_ - height
        
        
        col_ = col_ + 1
        left_ = left_ +  width
        
        
    }
    
    row_ = 1.0; col_ = 2.0; top_ = 0.0; left_ = 0.0; width = btn.frame.width; height = btn.frame.height
    
    top_ = btn.frame.minY
    left_ = btn.frame.minX
    
    
    print(" ## tr2 check ###")
    left_ = btn.frame.minX + 2 * width
    top_ = top_ - height
    
tr2: while( row_ <= 1 && top_ >= 0 && col_ <= 2 && left_ <= MatchViewController.boardBounds!["right"]!  && left_ >= -1 * width/2){
        
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where  x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == Int(row_) && update[0] == -1 * Int(col_) ){
                return x
            }
            
        case let  x where x == status.prohibited_obstructed :
            break tr2
        default :
            
            if( update[1] == Int(row_) && update[0] == -1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
        
        row_ = row_ + 1
        top_ = top_ - height
        
        
        col_ = col_ + 1
        left_ = left_ +  width
        
        
    }
    
    row_ = 1.0; col_ = 2.0; top_ = 0.0; left_ = 0.0; width = btn.frame.width; height = btn.frame.height
    top_ = btn.frame.minY
    left_ = btn.frame.minX
    
    
    print(" ## tl1 check ###")
    left_ = btn.frame.minX -  2 * width
    top_ = top_ - height
    
tl1:while( row_ <= 1 && top_ >= 0 && col_ <= 2 && left_ <= MatchViewController.boardBounds!["right"]!  && left_ >= -1 * width/2){
        
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where  x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == Int(row_) && update[0] == 1 * Int(col_) ){
                return x
            }
            
        case let  x where x == status.prohibited_obstructed :
            break tl1
        default :
            
            if( update[1] == Int(row_) && update[0] == 1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
        
        row_ = row_ + 1
        top_ = top_ - height
        
        
        col_ = col_ + 1
        left_ = left_ -  width
        
        
    }
    
    row_ = 1.0; col_ = 2.0; top_ = 0.0; left_ = 0.0; width = btn.frame.width; height = btn.frame.height
    top_ = btn.frame.minY
    left_ = btn.frame.minX
    
    
    print(" ## tl2 check ###")
    left_ = btn.frame.minX -  1 * width
    top_ = top_ - 2 * height
    
tl2:while( row_ <= 2 && top_ >= 0 && col_ <= 1 && left_ <= MatchViewController.boardBounds!["right"]!  && left_ >= -1 * width/2){
        
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where  x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == Int(row_) && update[0] == 1 * Int(col_) ){
                return x
            }
            
        case let  x where x == status.prohibited_obstructed :
            break tl2
        default :
            
            if( update[1] == Int(row_) && update[0] == 1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
        
        row_ = row_ + 1
        top_ = top_ - height
        
        
        col_ = col_ + 1
        left_ = left_ -  width
        
        
    }
    
    print(" ## dl1 check ###")
    row_ = 1.0; col_ = 2.0; top_ = 0.0; left_ = 0.0; width = btn.frame.width; height = btn.frame.height
    top_ = btn.frame.minY
    left_ = btn.frame.minX
    left_ = btn.frame.minX - 2 * width
    top_ = top_ + height
    
dl1:while(row_ <= 1 && top_ <= MatchViewController.boardBounds!["bottom"]!  && col_ <= 2 && left_ <= MatchViewController.boardBounds!["right"]!  && left_ >= -1 * width/2){
        
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where  x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == -1 * Int(row_) && update[0] == 1 * Int(col_) ){
                return x
            }
            
        case let  x where  x == status.prohibited_obstructed :
            break dl1
             
        default :
            
            if( update[1] == -1 * Int(row_) && update[0] == 1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
        
        row_ = row_ + 1
        top_ = top_ + height
        
        
        col_ = col_ + 1
        left_ = left_ -  width
        
        
    }
    
    
    
    print(" ## dl2 check ###")
    row_ = 2.0; col_ = 1.0; top_ = 0.0; left_ = 0.0; width = btn.frame.width; height = btn.frame.height
    top_ = btn.frame.minY
    left_ = btn.frame.minX
    left_ = btn.frame.minX - 1 * width
    top_ = top_ + 2 * height
    
dl2:while(row_ <= 2 && top_ <= MatchViewController.boardBounds!["bottom"]!  && col_ <= 1 && left_ <= MatchViewController.boardBounds!["right"]!  && left_ >= -1 * width/2){
        
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where  x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == -1 * Int(row_) && update[0] == 1 * Int(col_) ){
                return x
            }
            
        case let  x where  x == status.prohibited_obstructed :
            break dl2
             
        default :
            
            if( update[1] == -1 * Int(row_) && update[0] == 1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
        
        row_ = row_ + 1
        top_ = top_ + height
        
        
        col_ = col_ + 1
        left_ = left_ -  width
        
        
    }
    
    row_ = 1.0; col_ = 2.0; top_ = 0.0; left_ = 0.0; width = btn.frame.width; height = btn.frame.height
    top_ = btn.frame.minY
    left_ = btn.frame.minX
    
    
    print(" ## dr1 check ###")
    left_ = btn.frame.minX + 2 * width
    top_ = top_ + height
    
dr1: while(row_ <= 1 && top_ <= MatchViewController.boardBounds!["bottom"]!  && col_ <= 2 && left_ <= MatchViewController.boardBounds!["right"]!  && left_ >= -1 * width/2){
        
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == -1 * Int(row_) && update[0] == -1 * Int(col_) ){
                return x
            }
            
        case let  x where x == status.prohibited_obstructed :
            break dr1
        default :
            
            if( update[1] == -1 * Int(row_) && update[0] == -1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
        
        row_ = row_ + 1
        top_ = top_ + height
        
        
        col_ = col_ + 1
        left_ = left_ +  width
        
        
    }
    row_ = 2.0; col_ = 1.0; top_ = 0.0; left_ = 0.0; width = btn.frame.width; height = btn.frame.height
    top_ = btn.frame.minY
    left_ = btn.frame.minX
    
    
    print(" ## dr2 check ###")
    left_ = btn.frame.minX + 1 * width
    top_ = top_ + 2 * height
    
dr2: while(row_ <= 2 && top_ <= MatchViewController.boardBounds!["bottom"]!  && col_ <= 1 && left_ <= MatchViewController.boardBounds!["right"]!  && left_ >= -1 * width/2){
        
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == -1 * Int(row_) && update[0] == -1 * Int(col_) ){
                return x
            }
            
        case let  x where x == status.prohibited_obstructed :
            break dr2
        default :
            
            if( update[1] == -1 * Int(row_) && update[0] == -1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
        
        row_ = row_ + 1
        top_ = top_ + height
        
        
        col_ = col_ + 1
        left_ = left_ +  width
        
        
    }
    

    
    
    
    

    
    
    
    
  
    return status.prohibited_inCorrentPattern
    
    
    
}
func bishop(_ btn:UIButton! ,_ update: [Int], _ dest:UIButton?) ->status{
    
    
    var row_ = 1.0, col_ = 1.0, top_ = 0.0, left_ = 0.0, width = btn.frame.width, height = btn.frame.height
    top_ = btn.frame.minY
    left_ = btn.frame.minX
    
    
    print(" ## tl check ###")
    left_ = btn.frame.minX - width
    top_ = top_ - height
    
tl:while( row_ <= 8 && top_ >= 0 && col_ <= 8 && left_ <= MatchViewController.boardBounds!["right"]!  && left_ >= -1 * width/2){
        
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where  x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == Int(row_) && update[0] == 1 * Int(col_) ){
                return x
            }
            
        case let  x where x == status.prohibited_obstructed :
            break tl
        default :
            
            if( update[1] == Int(row_) && update[0] == 1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
        
        row_ = row_ + 1
        top_ = top_ - height
        
        
        col_ = col_ + 1
        left_ = left_ -  width
        
        
    }
    
    
    
    row_ = 1.0; col_ = 1.0; top_ = 0.0; left_ = 0.0; width = btn.frame.width; height = btn.frame.height
    top_ = btn.frame.minY
    left_ = btn.frame.minX
    
    
    print(" ## tr check ###")
    left_ = btn.frame.minX + width
    top_ = top_ - height
    
tr: while( row_ <= 8 && top_ >= 0 && col_ <= 8 && left_ <= MatchViewController.boardBounds!["right"]!  && left_ >= -1 * width/2){
        
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where  x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == Int(row_) && update[0] == -1 * Int(col_) ){
                return x
            }
            
        case let  x where x == status.prohibited_obstructed :
            break tr
        default :
            
            if( update[1] == Int(row_) && update[0] == -1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
        
        row_ = row_ + 1
        top_ = top_ - height
        
        
        col_ = col_ + 1
        left_ = left_ +  width
        
        
    }
    

    
    
    print(" ## dl check ###")
    row_ = 1.0; col_ = 1.0; top_ = 0.0; left_ = 0.0; width = btn.frame.width; height = btn.frame.height
    top_ = btn.frame.minY
    left_ = btn.frame.minX
    left_ = btn.frame.minX - width
    top_ = top_ + height
    
dl:while(row_ <= 8 && top_ <= MatchViewController.boardBounds!["bottom"]!  && col_ <= 8 && left_ <= MatchViewController.boardBounds!["right"]!  && left_ >= -1 * width/2){
        
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where  x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == -1 * Int(row_) && update[0] == 1 * Int(col_) ){
                return x
            }
            
        case let  x where  x == status.prohibited_obstructed :
            break dl
             
        default :
            
            if( update[1] == -1 * Int(row_) && update[0] == 1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
        
        row_ = row_ + 1
        top_ = top_ + height
        
        
        col_ = col_ + 1
        left_ = left_ -  width
        
        
    }
    
    
    row_ = 1.0; col_ = 1.0; top_ = 0.0; left_ = 0.0; width = btn.frame.width; height = btn.frame.height
    top_ = btn.frame.minY
    left_ = btn.frame.minX
    
    
    print(" ## dr check ###")
    left_ = btn.frame.minX + width
    top_ = top_ + height
    
dr: while(row_ <= 8 && top_ <= MatchViewController.boardBounds!["bottom"]!  && col_ <= 8 && left_ <= MatchViewController.boardBounds!["right"]!  && left_ >= -1 * width/2){
        
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == -1 * Int(row_) && update[0] == -1 * Int(col_) ){
                return x
            }
            
        case let  x where x == status.prohibited_obstructed :
            break dr
        default :
            
            if( update[1] == -1 * Int(row_) && update[0] == -1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
        
        row_ = row_ + 1
        top_ = top_ + height
        
        
        col_ = col_ + 1
        left_ = left_ +  width
        
        
    }
    

    return status.prohibited_inCorrentPattern
}
   

func king(_ btn:UIButton! ,_ update: [Int], _ dest:UIButton?)->status{
    
    
    print(" rook pattern with 1 constraint ")
    
    var row_ = 1.0, col_ = 0.0, top_ = 0.0, left_ = 0.0, width = btn.frame.width, height = btn.frame.height
    top_ = btn.frame.minY
    left_ = btn.frame.minX
    
    top_ = top_ - height
    
t:while( row_ <= 1 && top_ >= 0 && left_ >= 0){
            print(" top check for 1 box ")
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where  x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == Int(row_) && update[0] == -1 * Int(col_) ){
                return x
            }
            
        case let  x where x == status.prohibited_obstructed :
            break t
        default :
            
            if( update[1] == Int(row_) && update[0] == -1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1]) \(update[1] == Int(row_)) \(update[0] == 1 * Int(col_))")
        }
            
        row_ = row_ + 1
        top_ = top_ - height
        }
    print(" ## checking bottom traversal ##")
    row_ = 1.0; col_ = 0.0; top_ = 0.0; left_ = 0.0; width = btn.frame.width; height = btn.frame.height
    top_ = btn.frame.minY + height
    left_ = btn.frame.minX
    
btm: while( row_ <= 1 && top_ <= MatchViewController.boardBounds!["bottom"]!  && left_ >= 0){
            
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where  x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == -1 * Int(row_) && update[0] == -1 * Int(col_) ){
                print(" kill confirm ")
                return x
            }
        case let  x where x == status.prohibited_obstructed :
            break btm
            
        default :
            
            if( update[1] == -1 *
                
                 Int(row_) && update[0] == -1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
            
        row_ = row_ + 1
        top_ = top_ + height
        }
    
    print(" checking left travel ")
    row_ = 0.0; col_ = 1.0; top_ = 0.0; left_ = 0.0; width = btn.frame.width; height = btn.frame.height
    top_ = btn.frame.minY
    left_ = btn.frame.minX - width
    
lft: while( col_ <= 1 && left_ <= MatchViewController.boardBounds!["right"]!  && left_ >= -1 * width/2){
            
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == 0 * Int(row_) && update[0] == -1 * Int(col_) ){
                print(" kill confirm ")
                return x
            }
        case let  x where x == status.prohibited_obstructed :
            break lft
        default:
            if( update[1] == 0 *
                
                 Int(row_) && update[0] == 1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
            
        col_ = col_ + 1
        left_ = left_ -  width
        
        }
    
    
    print(" checking right travel ")
    row_ = 0.0; col_ = 1.0; top_ = 0.0; left_ = 0.0; width = btn.frame.width; height = btn.frame.height
    top_ = btn.frame.minY
    left_ = btn.frame.minX + width
    
ryt:while( col_ <= 1 && left_ <= MatchViewController.boardBounds!["right"]!  && left_ >= 0){
            
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == 0 * Int(row_) && update[0] == -1 * Int(col_) ){
                print(" kill confirm ")
                return x
            }
        case let  x where x == status.prohibited_obstructed :
            break ryt
            
        default:
            if( update[1] == 0 *
                
                 Int(row_) && update[0] == -1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
            
        col_ = col_ + 1
        left_ = left_ + width
        
        }
    
    
    print(" checking bisgop with 1 box constraint ")
    
    
    row_ = 1.0; col_ = 1.0; top_ = 0.0; left_ = 0.0; width = btn.frame.width; height = btn.frame.height
    top_ = btn.frame.minY
    left_ = btn.frame.minX
    
    
    print(" ## tl check ###")
    left_ = btn.frame.minX - width
    top_ = top_ - height
    
tl:while( row_ <= 1 && top_ >= 0 && col_ <= 1 && left_ <= MatchViewController.boardBounds!["right"]!  && left_ >= -1 * width/2){
        
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where  x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == Int(row_) && update[0] == 1 * Int(col_) ){
                return x
            }
            
        case let  x where x == status.prohibited_obstructed :
            break tl
        default :
            
            if( update[1] == Int(row_) && update[0] == 1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
        
        row_ = row_ + 1
        top_ = top_ - height
        
        
        col_ = col_ + 1
        left_ = left_ -  width
        
        
    }
    
    
    
    row_ = 1.0; col_ = 1.0; top_ = 0.0; left_ = 0.0; width = btn.frame.width; height = btn.frame.height
    top_ = btn.frame.minY
    left_ = btn.frame.minX
    
    
    print(" ## tr check ###")
    left_ = btn.frame.minX + width
    top_ = top_ - height
    
tr: while( row_ <= 1 && top_ >= 0 && col_ <= 1 && left_ <= MatchViewController.boardBounds!["right"]!  && left_ >= -1 * width/2){
        
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where  x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == Int(row_) && update[0] == -1 * Int(col_) ){
                return x
            }
            
        case let  x where x == status.prohibited_obstructed :
            break tr
        default :
            
            if( update[1] == Int(row_) && update[0] == -1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
        
        row_ = row_ + 1
        top_ = top_ - height
        
        
        col_ = col_ + 1
        left_ = left_ +  width
        
        
    }
    

    
    
    print(" ## dl check ###")
    row_ = 1.0; col_ = 1.0; top_ = 0.0; left_ = 0.0; width = btn.frame.width; height = btn.frame.height
    top_ = btn.frame.minY
    left_ = btn.frame.minX
    left_ = btn.frame.minX - width
    top_ = top_ + height
    
dl:while(row_ <= 1 && top_ <= MatchViewController.boardBounds!["bottom"]!  && col_ <= 1 && left_ <= MatchViewController.boardBounds!["right"]!  && left_ >= -1 * width/2){
        
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where  x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == -1 * Int(row_) && update[0] == 1 * Int(col_) ){
                return x
            }
            
        case let  x where  x == status.prohibited_obstructed :
            break dl
             
        default :
            
            if( update[1] == -1 * Int(row_) && update[0] == 1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
        
        row_ = row_ + 1
        top_ = top_ + height
        
        
        col_ = col_ + 1
        left_ = left_ -  width
        
        
    }
    
    
    row_ = 1.0; col_ = 1.0; top_ = 0.0; left_ = 0.0; width = btn.frame.width; height = btn.frame.height
    top_ = btn.frame.minY
    left_ = btn.frame.minX
    
    
    print(" ## dr check ###")
    left_ = btn.frame.minX + width
    top_ = top_ + height
    
dr: while(row_ <= 1 && top_ <= MatchViewController.boardBounds!["bottom"]!  && col_ <= 1 && left_ <= MatchViewController.boardBounds!["right"]!  && left_ >= -1 * width/2){
        
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == -1 * Int(row_) && update[0] == -1 * Int(col_) ){
                return x
            }
            
        case let  x where x == status.prohibited_obstructed :
            break dr
        default :
            
            if( update[1] == -1 * Int(row_) && update[0] == -1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
        
        row_ = row_ + 1
        top_ = top_ + height
        
        
        col_ = col_ + 1
        left_ = left_ +  width
        
        
    }
    

    return status.prohibited_inCorrentPattern
    
        
    
    
}

    
    

func rook(_ btn:UIButton! ,_ update: [Int], _ dest:UIButton?) ->status{
    
    
    var row_ = 1.0, col_ = 0.0, top_ = 0.0, left_ = 0.0, width = btn.frame.width, height = btn.frame.height
    top_ = btn.frame.minY
    left_ = btn.frame.minX
    
    top_ = top_ - height
    row_ = row_ + 1
t:while( row_ <= 8 && top_ >= 0 && left_ >= 0){
            
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where  x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == Int(row_) && update[0] == -1 * Int(col_) ){
                return x
            }
            
        case let  x where x == status.prohibited_obstructed :
            break t
        default :
            
            if( update[1] == Int(row_) && update[0] == -1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
            
        row_ = row_ + 1
        top_ = top_ - height
        }
    print(" ## checking bottom traversal ##")
    row_ = 1.0; col_ = 0.0; top_ = 0.0; left_ = 0.0; width = btn.frame.width; height = btn.frame.height
    top_ = btn.frame.minY + height
    left_ = btn.frame.minX
    
btm: while( row_ <= 8 && top_ <= MatchViewController.boardBounds!["bottom"]!  && left_ >= 0){
            
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where  x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == -1 * Int(row_) && update[0] == -1 * Int(col_) ){
                print(" kill confirm ")
                return x
            }
        case let  x where x == status.prohibited_obstructed :
            break btm
            
        default :
            
            if( update[1] == -1 *
                
                 Int(row_) && update[0] == -1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
            
        row_ = row_ + 1
        top_ = top_ + height
        }
    
    print(" checking left travel ")
    row_ = 0.0; col_ = 1.0; top_ = 0.0; left_ = 0.0; width = btn.frame.width; height = btn.frame.height
    top_ = btn.frame.minY
    left_ = btn.frame.minX - width
    
lft: while( col_ <= 8 && left_ <= MatchViewController.boardBounds!["right"]!  && left_ >= -1 * width/2){
            
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == 0 * Int(row_) && update[0] == -1 * Int(col_) ){
                print(" kill confirm ")
                return x
            }
        case let  x where x == status.prohibited_obstructed :
            break lft
        default:
            if( update[1] == 0 *
                
                 Int(row_) && update[0] == 1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
            
        col_ = col_ + 1
        left_ = left_ -  width
        
        }
    
    
    print(" checking right travel ")
    row_ = 0.0; col_ = 1.0; top_ = 0.0; left_ = 0.0; width = btn.frame.width; height = btn.frame.height
    top_ = btn.frame.minY
    left_ = btn.frame.minX + width
    
ryt:while( col_ <= 8 && left_ <= MatchViewController.boardBounds!["right"]!  && left_ >= 0){
            
        var res = match(top_, left_ , dest)
        switch(res){
        case let  x where x == status.granted_killing :
            print("obs | kill 2 \(row_) \(col_) \(update[1]) \(update[0])")
            if( update[1] == 0 * Int(row_) && update[0] == -1 * Int(col_) ){
                print(" kill confirm ")
                return x
            }
        case let  x where x == status.prohibited_obstructed :
            break ryt
            
        default:
            if( update[1] == 0 *
                
                 Int(row_) && update[0] == -1 * Int(col_) ){
                print(" returned plain ")
                return status.granted_plain
            }
            print(" default II - \(row_) \(col_) \(update[0]) \(update[1])")
        }
            
        col_ = col_ + 1
        left_ = left_ + width
        
        }
    
    
    return status.prohibited_inCorrentPattern
        
    }
    
    
    
    
    


