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
    
    let customBlue = UIColor(displayP3Red: 105/255, green: 200/255, blue: 252/255, alpha: 1)
    let customGray = UIColor(displayP3Red: 125/255, green: 120/255, blue: 120/255, alpha: 1)
    
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
    
    let titleSize = UIFont(name: "Damascus", size: 20)
    let fontSize = UIFont(name: "Damascus", size: 15)

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
