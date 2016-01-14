//
//  OntbijtDetailsViewController.swift
//  KoffiehuisOntbijtBesteller
//
//  Created by Dean Delanoye on 24/12/15.
//  Copyright © 2015 dean delanoye. All rights reserved.
//

import UIKit

class OntbijtDetailsViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var goToReserveerBtn: UIButton!
    @IBOutlet weak var ontbijtImage: UIImageView!
    
    @IBOutlet weak var centerAlignDescriptionLbl: NSLayoutConstraint!
    @IBOutlet weak var centerAlignPriceLbl: NSLayoutConstraint!
    @IBOutlet weak var bottomReserveerConstraint: NSLayoutConstraint!
    
    var ontbijt: Ontbijt!
    
    override func viewDidLoad() {
        title = ontbijt.name
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.preferredMaxLayoutWidth = 250
        descriptionLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        descriptionLabel.sizeToFit()
        descriptionLabel.text = ontbijt.description
        
        
        /* controle vrijdag prestige */
        let today = NSDate()
        let vrijdag = today.weekDayName
        
        if(ontbijt.name == "Prestige") {
            
            //print("ontbijt prestige geselecteerd !")
            if(vrijdag == "vrijdag") {
               // print("vrijdag prestige prijs")
                ontbijt.price = 16.00
            } else {
               // print("normale prijs")
                ontbijt.price = 17.50
            }
        }
        
        
        priceLabel.text =  String(format:"€ %.2f", ontbijt.price)
        
        ontbijtImage.image = ontbijt.image
        ontbijtImage.clipsToBounds = true
        ontbijtImage.layer.cornerRadius = 10
        ontbijtImage.layer.borderWidth = 3
        ontbijtImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        goToReserveerBtn.layer.cornerRadius = 6
        goToReserveerBtn.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        centerAlignDescriptionLbl.constant -= view.bounds.width
        centerAlignPriceLbl.constant += view.bounds.width
        bottomReserveerConstraint.constant -= view.bounds.height
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.centerAlignDescriptionLbl.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.centerAlignPriceLbl.constant -= self.view.bounds.width
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.5, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.bottomReserveerConstraint.constant += self.view.bounds.height
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
}