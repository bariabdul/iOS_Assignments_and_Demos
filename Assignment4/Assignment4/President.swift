//
//  President.swift
//  Assignment4
//
//  Created by Bari Abdul on 11/2/16.
//  Copyright © 2016 Bari Abdul. All rights reserved.
//

import Foundation

//this swift file will initialize the President class member variables
class President {
    var name = ""
    var number: Int
    var startDate = ""
    var endDate = ""
    var nickname = ""
    var politicalParty = ""
    
    init(name: String, number: Int, startDate: String, endDate: String, nickname: String, politicalParty: String) {
        
        self.name = name
        self.number = number
        self.startDate = startDate
        self.endDate = endDate
        self.nickname = nickname
        self.politicalParty = politicalParty
    }
    
}