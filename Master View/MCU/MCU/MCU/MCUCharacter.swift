//
//  MCUCharacter.swift
//  MCU
//
//  Created by Kurt McMahon on 10/13/16.
//  Copyright © 2016 Northern Illinois University. All rights reserved.
//

import Foundation

class MCUCharacter {
    var name = ""
    var realName = ""
    var allegiance = ""
    
    init(name: String, realName: String, allegiance: String) {
        self.name = name
        self.realName = realName
        self.allegiance = allegiance
    }
}
