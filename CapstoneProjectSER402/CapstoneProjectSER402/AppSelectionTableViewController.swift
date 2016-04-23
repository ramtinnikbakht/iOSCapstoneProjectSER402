//
//  SuggestedAppsTableViewController.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 3/6/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit

class AppSelectionTableViewController: UITableViewController {
    
    
    var usertype: String = ""
    var appAreasSelection = [String]()
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

    
    var apps = [BusinessApp]()
    var appsTitleArray = [String]()
    //var appsArray: [String] = ["Area1App1", "Area1App2", "Area1App3", "Area2App1", "Area2App2", "Area3App1", "Area3App2", "Area3App3", "Area3App4"]
    var selectedApps = [String]()

    //var mockApps = [String]()
    /*struct Sections {
        var sectionName: String!
        var sectionContents: [String]!
    }*/
    
    //var sectionsArray = [Sections]()
    
  
    @IBAction func selectAllButtonPressed(sender: UIButton) {
        let section = 2
        for (var row = 0; row < tableView.numberOfRowsInSection(section); ++row) {
            tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: section))?.tintColor = UIColor(red: 0/255.0,
                                                                                                               green: 64/255.0,
                                                                                                               blue: 128/255.0,
                                                                                                               alpha: 1.0)
            tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: section))?.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            
        }
        selectedApps = appsTitleArray
        print(selectedApps)
        //selectedApps = mockApps
        print(selectedApps)
    }
    
    @IBAction func clearSelectionButtonPressed(sender: UIButton) {
        let section = 2
        for (var row = 0; row < tableView.numberOfRowsInSection(section); ++row) {
            
            tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: section))?.accessoryType = UITableViewCellAccessoryType.None
        }
        selectedApps = []
        print(selectedApps)
    }

    
    /*func application(application: UIApplication!, performFetchWithCompletionHandler completionHandler: ((UIBackgroundFetchResult) -> Void)!) {
        loadApps() {
            completionHandler(UIBackgroundFetchResult.NewData)
            print(self.apps.count)
        }
    }
    
    func loadApps(completionHandler: (() -> Void)!) {
        
        completionHandler()
    }*/
    
    var areas = [BusinessApp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Add if statement and logic to check for the app areas selected and grabbing apps only based on those selections
        
        /*ConnectionService.sharedInstance.getBusiness(appUnit: "311ab55b95b38980ce51a15d3638639c")
        apps = ConnectionService.sharedInstance.businessApps
        ConnectionService.sharedInstance.getBusiness(appArea: "29f0acd82b56b000b44bd4b419da1503")
        areas = ConnectionService.sharedInstance.businessApps
        */
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

        //apps = ConnectionService.sharedInstance.getBusiness(appUnit: "311ab55b95b38980ce51a15d3638639c")
        //let myTimer : NSTimer = NSTimer.scheduledTimerWithTimeInterval(24, target: self, selector: Selector("myPerformeCode:"), userInfo: nil, repeats: false)
        for area in areas {
            print("app Area \(area.businessApp)")
        }
        
        for appArea in appAreasSelection {
            if appArea == (area1.first?.businessArea)! {
                for apps in area1 {
                    appsTitleArray.append(apps.businessApp)
                }
            }
            if appArea == (area3.first?.businessArea)! {
                for apps in area3 {
                    appsTitleArray.append(apps.businessApp)
                }
                
            }
            if appArea == "" {
                
            }
            if appArea == "" {
                
            }
            if appArea == "" {
                
            }
            if appArea == "" {
                
            }
            if appArea == "" {
                
            }
            if appArea == "" {
                
            }
            if appArea == "" {
                
            }
            if appArea == "" {
                
            }
            if appArea == "" {
                
            }
            if appArea == "" {
                
            }
            if appArea == "" {
                
            }
            if appArea == "" {
                
            }
            if appArea == "" {
                
            }
            if appArea == "" {
                
            }
        }
        
        /*if appAreasSelection.contains("Area1") {
            mockApps.append(appsArray[0])
            mockApps.append(appsArray[1])
            mockApps.append(appsArray[2])
            
        }
        if appAreasSelection.contains("Area2") {
            mockApps.append(appsArray[3])
            mockApps.append(appsArray[4])
            
        }
        if appAreasSelection.contains("Area3") {
            mockApps.append(appsArray[5])
            mockApps.append(appsArray[6])
            mockApps.append(appsArray[7])
            mockApps.append(appsArray[8])
            
        }
        */
        /*for app in apps {
            appsTitleArray.append(app.businessSubUnit)
            print("app title: \(appsTitleArray)")
            
        }*/

        //print(apps)
        //print(apps.count)
        //print(mockApps)

        /*let alert = UIAlertController(title: "Alert", message: "Your User Type: \(usertype)", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        */
        
        //sectionsArray = [Sections(sectionName: "Configuration", sectionContents: ["Select All", "UnSelect All"]), Sections(sectionName: "Select Your Apps", sectionContents: ["App1", "App2", "App3", "App4", "App5", "App6", "App7"])]

        
        //setEditing(true, animated: true)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        //userTypeLabel.text = usertype
        /*let alert = UIAlertController(title: "Alert", message: "Your User Type: \(usertype)", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)*/
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("usertypecell") as! UserTypeTableViewCell!
            
            cell.userTypeLabel.text = usertype
            
            return cell!
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("appsoptioncell") as! AppsOptionTableViewCell!
            
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("appscell") as! AppSelectionTableViewCell!
        
        //cell.appsTitleLabel.text = apps[indexPath.row].businessApp
        cell.appsTitleLabel.text = appsTitleArray[indexPath.row]
        return cell
    }
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {

        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        }
        //return apps.count
        return appsTitleArray.count
        
        //return sectionsArray[section].sectionContents.count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section == 0 {
            return "User Type"
        }
        if section == 1 {
            return "Options"
        } else {
            return "Apps"
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 17.0
        } else if section == 2 {
            return 17.0
        }
        return 30.0
    }
    /*override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
    }*/
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 {
            let usertypecell = tableView.cellForRowAtIndexPath(indexPath) as! UserTypeTableViewCell!
            usertypecell.selectionStyle = UITableViewCellSelectionStyle.None
        }
        else if indexPath.section == 1 {
            let optionscell = tableView.cellForRowAtIndexPath(indexPath) as! AppsOptionTableViewCell!
            optionscell.selectionStyle = UITableViewCellSelectionStyle.None
            
        } else {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! AppSelectionTableViewCell!
        
        if selectedApps.contains(cell.appsTitleLabel.text!) {
            
            cell.accessoryType = UITableViewCellAccessoryType.None
            selectedApps = selectedApps.filter {$0 != cell.appsTitleLabel.text!}
            print("worked")
            print(selectedApps)
        } else {
            cell.tintColor = UIColor(red: 0/255.0,
                                     green: 64/255.0,
                                     blue: 128/255.0,
                                     alpha: 1.0)
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        
            selectedApps += [cell.appsTitleLabel.text!]
        
            print(selectedApps)
            }
            
        }
    }
    
    
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
    {
        
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
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
