//
//  modelView.swift
//  face view
//
//  Created by Yermakov Anton on 17.07.17.
//  Copyright © 2017 Yermakov Anton. All rights reserved.
//

import Foundation

struct Model{
    
  enum Eyes : Int{
        case open
        case closed
        case squinting
    }
    
    enum Mouth : Int{
        case frown
        case smirk
        case neutral
        case grin
        case smile
        
        var sadder  : Mouth{
            return Mouth(rawValue: rawValue - 1) ?? .frown
        }
        
        var happier : Mouth{
            return Mouth(rawValue: rawValue + 1) ?? .smile
        }
    }
    
    var sadder : Model{
        return Model(eyes: self.eyes, mouth: self.mouth.sadder)
    }
    
    var happier : Model{
        return Model(eyes: self.eyes, mouth: self.mouth.happier)
    }
    
    
    var eyes : Eyes
    var mouth : Mouth
    
}
