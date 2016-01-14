//
//  MaakReservatieDeel1ViewController.swift
//  KoffiehuisOntbijtBesteller
//
//  Created by Dean Delanoye on 09/01/16.
//  Copyright © 2016 dean delanoye. All rights reserved.
//

import UIKit
import MessageUI

class MaakReservatieDeel1ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var reserveerBtn: UIBarButtonItem!
    @IBOutlet weak var annuleerBtn: UIButton!
    @IBOutlet weak var datePickerLbl: UILabel!
    @IBOutlet weak var selectedDate: UIDatePicker!
    @IBOutlet weak var errorLbl: UILabel!
    
    @IBOutlet weak var bottomAnnuleerConstraint: NSLayoutConstraint!
    
    var selectedDatum: NSDate = NSDate()
    var strWeekDay: String = ""
    var strHourOfDay: String = ""
    
    var reservatie: Reservatie!
    var strFormattedDate: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerLbl.numberOfLines = 0
        datePickerLbl.preferredMaxLayoutWidth = 250
        datePickerLbl.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        datePickerLbl.sizeToFit()
        datePickerLbl.text = "Selecteer een datum en uur (tussen 8u30 en 11u)"
        
        selectedDate.minimumDate = NSDate()
        
        annuleerBtn.layer.cornerRadius = 6
        annuleerBtn.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
        
        errorLbl.text = ""
        
        self.selectedDate.addTarget(self, action: Selector("dateControl:"), forControlEvents: UIControlEvents.ValueChanged)
        reserveerBtn.enabled = false
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        bottomAnnuleerConstraint.constant -= view.bounds.height
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.bottomAnnuleerConstraint.constant += self.view.bounds.height
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func dateControl(sender: UIDatePicker) {
        strWeekDay = selectedDate.date.weekDayName
        strHourOfDay = selectedDate.date.hourFromDay
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        let beginOntbijt = formatter.dateFromString("8:30")
        let eindeOntbijt = formatter.dateFromString("11:00")
        
        if (isInInterval(selectedDatum.HourFromDayDate, startTime: beginOntbijt!, endTime: eindeOntbijt!) ){
            print("in timestamp")
            
            if(strWeekDay == "maandag" || strWeekDay == "dinsdag") {
                
                errorLbl.text = "OPGEPAST, we zijn dan gesloten!"
                reserveerBtn.enabled = false
            } else {
                
                errorLbl.text = ""
                reserveerBtn.enabled = true
            }
            
        } else {
            
            errorLbl.text = "Niet mogelijk"
            reserveerBtn.enabled = false
            
        }
        
    }
    
    func isInInterval(date:NSDate, startTime:NSDate, endTime:NSDate)->Bool{
        if date.earlierDate(endTime) == date && date.laterDate(startTime) == date{
            return true
        }
        return false
    }
    
    @IBAction func selectDate(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE dd-MM-yyyy"
        let strDate = dateFormatter.stringFromDate(selectedDate.date)
        
        strFormattedDate = strDate
        print(strFormattedDate)
        selectedDatum = selectedDate.date
    }
    
    /* reserveer button with mail sender
    Archetapp : https://www.youtube.com/watch?v=02UnjWDWcis
    */
    @IBAction func Reserveren(sender: AnyObject) {
        let subject = "RESERVATIE ONTBIJT "
        
        let body = String(format:"Reservatie voor een ontbijt op naam van %@. We zullen met %@ zijn en nemen de formule %@. U kunt ons verwachten op %@",reservatie.name,reservatie.aantal, reservatie.ontbijtList.name,strFormattedDate)
        
        let recipients = ["delanoyedean@gmail.com"]
        
        let mc: MFMailComposeViewController =  MFMailComposeViewController()
        mc.mailComposeDelegate = self
        
        mc.setSubject(subject)
        mc.setMessageBody(body, isHTML: false)
        mc.setToRecipients(recipients)
        
        self.presentViewController(mc, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            NSLog("Mail Saved")
        case MFMailComposeResultSaved.rawValue:
            NSLog("Mail Saved")
        case MFMailComposeResultSent.rawValue:
            NSLog("Mail Sent")
        case MFMailComposeResultFailed.rawValue:
            NSLog("Mail Sent Failure: %@", [error!.localizedDescription])
        default:
            break
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        navigationController?.popViewControllerAnimated(true)
    }
    
    /* back to list with ontbijten */
    @IBAction func Annuleren(sender: AnyObject) {
        let mainView = self.storyboard?.instantiateViewControllerWithIdentifier("mainViewControllerID") as? OntbijtViewController
        self.navigationController?.pushViewController(mainView!, animated: true)
    }
    
    
}

/*
    stackoverflow response: http://stackoverflow.com/questions/27326196/displaying-the-day-of-the-week-from-date-picker
*/
extension NSDate {
    var weekDayName: String {
        let formatter = NSDateFormatter();
        formatter.dateFormat = "EEEE"
        return formatter.stringFromDate(self)
    }
    
    var hourFromDay: String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.stringFromDate(self)
    }
    
    var HourFromDayDate: NSDate {
        let formmatter = NSDateFormatter()
        formmatter.dateFormat = "HH:mm"
        return formmatter.dateFromString(self.hourFromDay)!
    }
}