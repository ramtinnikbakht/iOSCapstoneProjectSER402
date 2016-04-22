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

    var area1 = [BusinessApp]()
    var area2 = [BusinessApp]()
    var area3 = [BusinessApp]()
    var area4 = [BusinessApp]()
    var area5 = [BusinessApp]()
    var area6 = [BusinessApp]()
    var area7 = [BusinessApp]()
    var area8 = [BusinessApp]()
    var area9 = [BusinessApp]()
    var area10 = [BusinessApp]()
    var area11 = [BusinessApp]()
    var area12 = [BusinessApp]()
    var area13 = [BusinessApp]()
    var area14 = [BusinessApp]()
    var area15 = [BusinessApp]()
    var area16 = [BusinessApp]()
    var area17 = [BusinessApp]()
    var area18 = [BusinessApp]()
    var area19 = [BusinessApp]()
    var area20 = [BusinessApp]()
    var area21 = [BusinessApp]()
    var area22 = [BusinessApp]()
    var area23 = [BusinessApp]()
    var area24 = [BusinessApp]()
    var area25 = [BusinessApp]()
    var area26 = [BusinessApp]()
    var area27 = [BusinessApp]()
    var area28 = [BusinessApp]()
    var area29 = [BusinessApp]()
    var area30 = [BusinessApp]()
    var area31 = [BusinessApp]()
    var area32 = [BusinessApp]()
    var area33 = [BusinessApp]()
    var area34 = [BusinessApp]()
    var area35 = [BusinessApp]()
    
    var appsAreaArray = [String]()
    var selectedAppAreas = [String]()
    
    //var mockAppsAreaArray = ["Area1", "Area2", "Area3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectionService.sharedInstance.getBusiness(appArea: "0518483a31563c003ef8579138a26cdf")
        area1 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "06e9ec8413d9de04b04658222244b0b3")
        area2 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "06f0acd82b56b000b44bd4b419da1574")
        area3 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "0e9232910057dd40c29a5ad8ae8959bc")
        area4 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "12f0acd82b56b000b44bd4b419da1583")
        area5 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "18ae87f3bcf06940b6df35a196b27b31")
        area6 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "2628e0a5ec1fdd403d4de9b998cf6e37")
        area7 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "29f0acd82b56b000b44bd4b419da1503")
        area8 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "2df0acd82b56b000b44bd4b419da150b")
        area9 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "36f0ecd82b56b000b44bd4b419da1504")
        area10 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "3df0acd82b56b000b44bd4b419da1549")
        area11 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "3f7dce24cd412500b6df2c09e1e63faf")
        area12 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "440345a87d37b5843d4d58888f5462b8")
        area13 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "4642f6510057dd40c29a5ad8ae895956")
        area14 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "65f0acd82b56b000b44bd4b419da1501")
        area15 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "751c53970fed12008594348ce1050e64")
        area16 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "78280c3a31563c003ef8579138a26c4a")
        area17 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "80033b1d706865c03ef8f8f3b0ca9312")
        area18 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "a1f0acd82b56b000b44bd4b419da1502")
        area19 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "a5f0acd82b56b000b44bd4b419da1502")
        area20 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "a9f0acd82b56b000b44bd4b419da151a")
        area21 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "adf0acd82b56b000b44bd4b419da1502")
        area22 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "adf0acd82b56b000b44bd4b419da1504")
        area23 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "adf0acd82b56b000b44bd4b419da1505")
        area24 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "adf0acd82b56b000b44bd4b419da1506")
        area25 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "adf0acd82b56b000b44bd4b419da1508")
        area26 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "aef0acd82b56b000b44bd4b419da15b5")
        area27 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "b6f0acd82b56b000b44bd4b419da15ef")
        area28 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "c4b2b2910057dd40c29a5ad8ae8959ee")
        area29 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "d41575e8250342002ccc308250980f92")
        area30 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "e2c276910057dd40c29a5ad8ae8959c3")
        area31 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "e708083a31563c003ef8579138a26ceb")
        area32 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "e984503b0fae868004fd1d2be1050efa")
        area33 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "ec929f4b2b8c8140ce511be019da152c")
        area34 = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "f1a232910057dd40c29a5ad8ae8959fe")
        area35 = ConnectionService.sharedInstance.businessApps
        
        //areas.append("")
        //ConnectionService.sharedInstance.getBusiness("3df0acd82b56b000b44bd4b419da1549")
        //areas = ConnectionService.sharedInstance.businessApps
        appsAreaArray.append((area1.first?.businessArea)!)
        appsAreaArray.append((area2.first?.businessArea)!)
        appsAreaArray.append((area3.first?.businessArea)!)
        appsAreaArray.append((area4.first?.businessArea)!)
        appsAreaArray.append((area5.first?.businessArea)!)
        appsAreaArray.append((area6.first?.businessArea)!)
        appsAreaArray.append((area7.first?.businessArea)!)
        appsAreaArray.append((area8.first?.businessArea)!)
        appsAreaArray.append((area9.first?.businessArea)!)
        appsAreaArray.append((area10.first?.businessArea)!)
        appsAreaArray.append((area11.first?.businessArea)!)
        appsAreaArray.append((area12.first?.businessArea)!)
        appsAreaArray.append((area13.first?.businessArea)!)
        appsAreaArray.append((area14.first?.businessArea)!)
        appsAreaArray.append((area15.first?.businessArea)!)
        appsAreaArray.append((area16.first?.businessArea)!)
        appsAreaArray.append((area17.first?.businessArea)!)
        appsAreaArray.append((area18.first?.businessArea)!)
        appsAreaArray.append((area19.first?.businessArea)!)
        appsAreaArray.append((area20.first?.businessArea)!)
        appsAreaArray.append((area21.first?.businessArea)!)
        appsAreaArray.append((area22.first?.businessArea)!)
        appsAreaArray.append((area23.first?.businessArea)!)
        appsAreaArray.append((area24.first?.businessArea)!)
        appsAreaArray.append((area25.first?.businessArea)!)
        appsAreaArray.append((area26.first?.businessArea)!)
        appsAreaArray.append((area27.first?.businessArea)!)
        appsAreaArray.append((area28.first?.businessArea)!)
        appsAreaArray.append((area29.first?.businessArea)!)
        appsAreaArray.append((area30.first?.businessArea)!)
        appsAreaArray.append((area31.first?.businessArea)!)
        appsAreaArray.append((area32.first?.businessArea)!)
        appsAreaArray.append((area33.first?.businessArea)!)
        appsAreaArray.append((area34.first?.businessArea)!)
        appsAreaArray.append((area35.first?.businessArea)!)
        
        /*
        for area in mockAppsAreaArray {
            appsAreaArray.append(area)
        }
        */
        /*for area in areas {
            appsAreaArray.append(area.businessArea)
        }
        for area in areas2 {
            appsAreaArray.append(area.businessArea)
        }*/
        print(appsAreaArray)
        //areas = ConnectionService.sharedInstance.getBusiness(appUnit: "311ab55b95b38980ce51a15d3638639c")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        //print(areas)
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return appsAreaArray.count
    }
    
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            
        let cell = tableView.dequeueReusableCellWithIdentifier("apparea") as! AppAreaTableViewCell
        cell.appAreaTitleLabel.text = appsAreaArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! AppAreaTableViewCell!
        
        if selectedAppAreas.contains(cell.appAreaTitleLabel.text!) {
            
            cell.accessoryType = UITableViewCellAccessoryType.None
            selectedAppAreas = selectedAppAreas.filter {$0 != cell.appAreaTitleLabel.text!}
            print("worked")
            print(selectedAppAreas)
        } else {
            cell.tintColor = UIColor(red: 0/255.0,
                                     green: 64/255.0,
                                     blue: 128/255.0,
                                     alpha: 1.0)
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            selectedAppAreas += [cell.appAreaTitleLabel.text!]
            
            print(selectedAppAreas)
        }

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destViewController : AppSelectionTableViewController = segue.destinationViewController as! AppSelectionTableViewController
        destViewController.usertype = usertype
        destViewController.appAreasSelection = selectedAppAreas
        
        
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
