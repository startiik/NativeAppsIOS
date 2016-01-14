//
//  OntbijtViewController.swift
//  KoffiehuisOntbijtBesteller
//
//  Created by Dean Delanoye on 17/12/15.
//  Copyright © 2015 dean delanoye. All rights reserved.
//
import UIKit
import Social

class OntbijtViewController:  UITableViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate
{
    private var ontbijtModel = OntbijtModel()
    
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var shareLbl: UILabel!
    @IBOutlet weak var fbShareBtn: UIButton!
    @IBOutlet weak var twitterShareBtn: UIButton!
    
    let navigationCtrl = NavigationAnimationController()
    let interactionCtrl = InteractionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareLbl.numberOfLines = 0
        shareLbl.preferredMaxLayoutWidth = 250
        shareLbl.lineBreakMode = NSLineBreakMode.ByWordWrapping
        shareLbl.sizeToFit()
        shareLbl.text = " Deel ons applicatie op Facebook of op Twitter"
        
        shareView.frame = CGRectMake(0, 142, 600, view.bounds.height)
        
        fbShareBtn.clipsToBounds = true
        fbShareBtn.layer.cornerRadius = 10
        twitterShareBtn.clipsToBounds = true
        twitterShareBtn.layer.cornerRadius = 10
        
        navigationController?.delegate = self
        
    }
    
    /*
        animation : http://www.appcoda.com/view-animation-in-swift/
    */
    override func viewWillAppear(animated: Bool) {
        animateTable()
    }
    
    func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .Push {
            interactionCtrl.attachToViewController(toVC)
        }
        
        navigationCtrl.reverse = operation == .Pop
        return navigationCtrl
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return interactionCtrl.transitionInProgress ? interactionCtrl : nil
    }
    
    /*
        social media example found on :
        http://www.brianjcoleman.com/tutorial-share-facebook-twitter-swift/
    */
    @IBAction func twitterShareBtn(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("I just used the Koffiehuis Dantes App")
            twitterSheet.addImage(UIImage(named: "DTkoffie"))
            twitterSheet.addURL(NSURL(string: "http://www.koffiehuisdantes.be/Dantes/Dantes.html"))
            self.presentViewController(twitterSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share content.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.Default, handler: {
                
                (UIAlertAction) in
                
                let settingURL = NSURL(string: UIApplicationOpenSettingsURLString)
                
                if let url = settingURL {
                    UIApplication.sharedApplication().openURL(url)
                }
                
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    @IBAction func fbShareBtn(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            //DOESN'T WORK ANYMORE SINCE THE FACEBOOK POLICY SAY: NO APP MAY PRE FILL A POST.
            facebookSheet.setInitialText("I just used the Koffiehuis Dantes App")
            facebookSheet.addImage(UIImage(named: "DTkoffie"))
            facebookSheet.addURL(NSURL(string: "http://www.koffiehuisdantes.be/Dantes/Dantes.html"))
            
            self.presentViewController(facebookSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share content.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.Default, handler: {
                
                (UIAlertAction) in
                
                let settingURL = NSURL(string: UIApplicationOpenSettingsURLString)
                
                if let url = settingURL {
                    UIApplication.sharedApplication().openURL(url)
                }
                
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    /* code from: class exercice */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ontbijtModel.ontbijtList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        /* Custom cell */
        let cell = tableView.dequeueReusableCellWithIdentifier("ontbijtCell", forIndexPath: indexPath) as! OntbijtCell
        let ontbijt = ontbijtModel.ontbijtList[indexPath.row]
        cell.nameLabel.text = "\(ontbijt.name)"
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "details":
            let detailsController = segue.destinationViewController as! OntbijtDetailsViewController
            let selectedIndex = tableView.indexPathForSelectedRow!.row
            detailsController.ontbijt = ontbijtModel.ontbijtList[selectedIndex]
        default:
            break
        }
    }
    
}