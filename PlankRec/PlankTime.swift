//
//  PlankTime.swift
//  PlankRec
//
//  Created by Apple on 4/18/23.
//

import Foundation
struct PlankTime {
    
    
    func generateMsg(_ rec:Int)->String {
        switch rec {
        case 0...90:
            return "Bellow average \(rec)s"
        case 90...210:
            return "Average \(rec)s"
        default:
            return "Greate! \(rec)s"
        }
        
        
        
        
    }
   
}
