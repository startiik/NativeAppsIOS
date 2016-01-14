//
//  Reservatie.swift
//  KoffiehuisOntbijtBesteller
//
//  Created by Dean Delanoye on 24/12/15.
//  Copyright © 2015 dean delanoye. All rights reserved.
//

import UIKit

class Reservatie {
    
    var ontbijtList: Ontbijt
    var aantal: String
    var name: String
    var date: NSDate
    
    init(ontbijt: Ontbijt, aantal: String, name: String, date: NSDate) {
        self.ontbijtList = ontbijt
        self.aantal = aantal
        self.name = name
        self.date = date
    }
}
