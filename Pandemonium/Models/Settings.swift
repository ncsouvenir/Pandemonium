//
//  Settings.swift
//  Pandemonium
//
//  Created by C4Q on 2/5/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import UIKit

class Settings {
    private init() {}
    static let manager = Settings()
    
    let schemes = ["Normal", "Nightmode", "Cottoncandy"]
    
    let fontSize = UIFont(name: "Damascus", size: 15)
    let titleSize = UIFont(name: "Damascus", size: 20)
    
    var background = UIColor.white
    var textColor = UIColor.black
    
    public func colorSetting(_ button: String) {
        switch button {
        case "Normal":
            background = UIColor.white
            textColor = UIColor.black
        case "Nightmode":
            background = UIColor.black
            textColor = UIColor.white
        case "Cottoncandy":
            background = UIColor.purple
            textColor = UIColor.cyan
        default:
            break
        }
    }
}
