//
//  SetCard.swift
//  SetGame
//
//  Created by wesam Khallaf on 1/15/18.
//  Copyright © 2018 wesam Khallaf. All rights reserved.
//

import Foundation
import UIKit

class SetCard  {
    
    
    
    var colour  : UIColor = UIColor()
    var shape : String = "oval"
    var shadding : String = "open"
    var number : Int = 1
    
    
    init(color c : UIColor , shape s :String , shadding shad :String , number n :Int) {
        
        colour = c
        shape = s
        shadding = shad
        number = n
    }
    
    
    
    
    
    
    
}
