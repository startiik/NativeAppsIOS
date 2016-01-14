//
//  OntbijtModel.swift
//  KoffiehuisOntbijtBesteller
//
//  Created by Dean Delanoye on 22/12/15.
//  Copyright © 2015 dean delanoye. All rights reserved.
//

import UIKit

struct OntbijtModel {
    
    var ontbijtList: [Ontbijt] = [
        Ontbijt(name: "Express" ,description: "1 koffie of thee of warme chocolademelk, plus 1 koffiekoek" ,price: 4.20, image: UIImage(imageLiteral: "ontbijt1")),
        Ontbijt(name: "Classical" ,description: "Vers fruitsap,1 koffie of thee of chocolademelk, 1 pistolet, 1 koffiekoek, confituur, choco" ,price: 9.90, image: UIImage(imageLiteral: "ontbijt2")),
        Ontbijt(name: "Classical XL" ,description: "Vers fruitsap, kannetje koffie/thee/chocolademelk, 1 witte pistolet , 1 bruine pistolet, 1 koffiekoek, ham, kaas, eitje, confituur, choco" ,price: 14, image: UIImage(imageLiteral: "ontbijt3")),
        Ontbijt(name: "Prestige" ,description: "Glaasje cava, vers fruitsap, kannetje koffie/thee/chocolade, 1 witte pistolet, 1 bruine pistolet, 2 koffiekoeken, ham, kaas, eitje, confituur, choco" ,price: 17.50, image: UIImage(imageLiteral: "ontbijt4"))
        
    ]
    
}