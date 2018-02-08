//
//  DateFormatter.swift
//  Pandemonium
//
//  Created by Reiaz Gafar on 2/8/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

class DateFormatterManager {
    
    static func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    
}
