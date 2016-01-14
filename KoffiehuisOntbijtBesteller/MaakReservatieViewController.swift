//
//  MaakReservatieViewController.swift
//  KoffiehuisOntbijtBesteller
//
//  Created by Dean Delanoye on 24/12/15.
//  Copyright © 2015 dean delanoye. All rights reserved.
//

import UIKit
import MessageUI

class MaakReservatieViewController: UIViewController, MFMailComposeViewControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var OntbijtFormulePickviewer: UIPickerView!
    @IBOutlet weak var aantalTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var ReserveerBtn: UIBarButtonItem!
    
    @IBOutlet weak var aantalConstraint: NSLayoutConstraint!
    @IBOutlet weak var naamConstraint: NSLayoutConstraint!
    @IBOutlet weak var pickerConstraint: NSLayoutConstraint!
    
    var reservatie: Reservatie!
    var selectedOntbijt: Ontbijt!
    var selectedDate = NSDate()
    
    var nextControle: Bool = true
    
    var ontbijtModel = OntbijtModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.OntbijtFormulePickviewer.dataSource = self
        self.OntbijtFormulePickviewer.delegate = self
        
        self.aantalTxtField.addTarget(self, action: Selector("disableUITextField:"), forControlEvents: UIControlEvents.EditingChanged)
        self.nameTxtField.addTarget(self, action: Selector("disableUITextField:"), forControlEvents: UIControlEvents.EditingChanged)
        
        ReserveerBtn.enabled = false
       
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        aantalConstraint.constant -= view.bounds.width
        naamConstraint.constant += view.bounds.width
        pickerConstraint.constant -= view.bounds.width
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.aantalConstraint.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.1, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.naamConstraint.constant -= self.view.bounds.width
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.pickerConstraint.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /* dismissing keyboard on touch. */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func disableUITextField(sender: UITextField) {
        if sender.text!.isEmpty {
            ReserveerBtn.enabled = false
        }
    }
    
    /*  how to use pickerviewexample:
        http://sourcefreeze.com/ios-uipickerview-example-using-swift/
    */
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ontbijtModel.ontbijtList.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ontbijtModel.ontbijtList[row].name
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        selectedOntbijt =  ontbijtModel.ontbijtList[row]
        let aantalP = aantalTxtField.text
        let naam = nameTxtField.text
        
        reservatie = Reservatie(ontbijt: selectedOntbijt, aantal: aantalP!, name: naam!, date: selectedDate)
        
        if(aantalP >= "1" && naam != "" ) {
            ReserveerBtn.enabled = true
        } else {
            ReserveerBtn.enabled = false
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let maakReservatieDeel2Controller = segue.destinationViewController as! MaakReservatieDeel1ViewController
        
        maakReservatieDeel2Controller.reservatie = self.reservatie
    }
    
}