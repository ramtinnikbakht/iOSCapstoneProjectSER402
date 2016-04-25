//
//  AppAreaSelectionTableViewController.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 4/19/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class AppAreaSelectionTableViewController: UITableViewController {
    
    var usertype: String = ""
    
    var busArea = [BusinessArea]()
    var selectedAreas = [BusinessArea]()
    
    var appsAreaArray = [String]()
    var selectedAppAreas = [String]()
    var areasShown : [Bool] = []
    
    //var mockAppsAreaArray = ["Area1", "Area2", "Area3"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        ConnectionService.sharedInstance.getBusinessArea()
        busArea = ConnectionService.sharedInstance.areaList
        
        let shown = [Bool](count: busArea.count, repeatedValue: false)
        areasShown = shown
        
        for area in busArea
        {
            appsAreaArray.append(area.getName())
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "App Areas"
        
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ConnectionService.sharedInstance.areaList.count
    }
    
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCellWithIdentifier("apparea") as! AppAreaTableViewCell
        cell.appAreaTitleLabel.text = appsAreaArray[indexPath.row]
        if (selectedAppAreas.contains(appsAreaArray[indexPath.row])) {
            cell.accessoryType = .Checkmark
        } else {
            cell.tintColor = UIColor(red: 0/255.0, green: 64/255.0, blue: 128/255.0, alpha: 1.0)
            cell.accessoryType = .None
        }
        
        let lightGrey = UIColor.lightGrayColor()
        cell.layer.shadowColor = lightGrey.CGColor
        cell.layer.shadowRadius = 1.5
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowOffset = CGSizeZero
        cell.layer.masksToBounds = false
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! AppAreaTableViewCell!
        let selectedArea = cell.appAreaTitleLabel.text!
        
        if (selectedAppAreas.contains(selectedArea)) {
            selectedAppAreas = selectedAppAreas.filter {$0 != cell.appAreaTitleLabel.text!}
            cell.accessoryType = .None
        } else {
            cell.tintColor = UIColor(red: 0/255.0, green: 64/255.0, blue: 128/255.0, alpha: 1.0)
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            selectedAppAreas += [selectedArea]
        }
    }
    
    // MARK: - Animate Table View Cell
    
    // Row Animation
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (areasShown[indexPath.row] == false) {
            let cellPosition = indexPath.indexAtPosition(1)
            var delay : Double = Double(cellPosition) * 0.1
            
            if (delay >= 1.3) {
                delay = 0
            }
            
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 0, 0)
            cell.layer.transform = rotationTransform
            
            UIView.animateWithDuration(1.0, delay: delay, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.BeginFromCurrentState, animations: {
                cell.layer.transform = CATransform3DIdentity
                }, completion: { finished in
                    
            })
            areasShown[indexPath.row] = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let destViewController : AppSelectionTableViewController = segue.destinationViewController as! AppSelectionTableViewController
        destViewController.usertype = usertype
        sendSelectedApps()
        destViewController.appAreasSelection = selectedAreas
        
        
    }
    
    func sendSelectedApps()
    {
        selectedAreas.removeAll()
        for(var j = 0; j<selectedAppAreas.count;j++)
        {
            for(var k = 0;k<busArea.count;k++)
            {
                if selectedAppAreas[j] == busArea[k].getName()
                {
                    selectedAreas.append(busArea[k])
                }
            }
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
