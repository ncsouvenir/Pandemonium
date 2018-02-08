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
    
    var backgroundColor = UIColor.white
    var textColor = UIColor.black
    
    var logoPressed = false
    
    public func nightModeSwitch() {
        if logoPressed == true {
            backgroundColor = UIColor.black
            textColor = UIColor.white
        } else {
            backgroundColor = UIColor.white
            textColor = UIColor.black
        }
    }
    
    let fontSize = UIFont(name: "Damascus", size: 15)
    let titleSize = UIFont(name: "Damascus", size: 20)

    let schemes = ["Normal", "Nightmode"]
    
    public func colorSetting(_ button: String) {
        switch button {
        case "Normal":
            backgroundColor = UIColor.white
            textColor = UIColor.black
        case "Nightmode":
            backgroundColor = UIColor.black
            textColor = UIColor.white
        default:
            break
        }
    }
}
