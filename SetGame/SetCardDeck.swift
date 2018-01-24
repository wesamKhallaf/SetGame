//
//  SetCardDeck.swift
//  SetGame
//
//  Created by wesam Khallaf on 1/15/18.
//  Copyright © 2018 wesam Khallaf. All rights reserved.
//

import Foundation
import UIKit


class SetCardDeck {
    
    var cards = [SetCard]()
    let  colors = [UIColor.green , UIColor.red ,UIColor.blue]
    let shapes = ["squiggle","diamond","oval"]
    let shades = ["hashed","open","solid"]
    
    init()
    {
       // let card : SetCard = SetCard()
        
        for i in 1...3
        {
            
            
            for shape in shapes
            {
               
                for color in colors
                {
                    
                    for shade in shades
                    {
                       
                       let  newcard = SetCard(color: color, shape: shape, shadding: shade, number: i)
                        cards.append(newcard)
                        
                        print("total number of cards in the Deck is \(cards.count)")
                    }
                    
                }
            }
            
            
            
        }
        
        
    }
    
    func drawCard() -> SetCard {
        
        let random = cards.count.arc4random
        
      
        
        return cards.remove(at: random)
    }
    
}
extension Int
{
    
    var arc4random : Int
    {
        
        if self > 0
        {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0
        {
            return -Int(arc4random_uniform(UInt32(self)))
        }
            
        else
        {
            return 0
            
        }
    }
    
}
