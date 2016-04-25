//
//  UserProfilePreferencesTableViewController.swift
//  CapstoneProjectSER402
//
//  Created by Ramtin Nikbakht on 4/23/16.
//  Copyright © 2016 Ramtin Nikbakht. All rights reserved.
//

import UIKit
import CoreData

class UserProfilePreferencesTableViewController: UITableViewController {
    
    var context:NSManagedObjectContext?
    
    var myApps = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        context = appDel.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "BusinessApps")
        do
        {
            let results:NSArray = try context!.executeFetchRequest(fetchRequest)
            
            for var i = 0; i < results.count; i++
            {
                
                myApps.append(results[i].valueForKey("businessApp") as! String!)
            }
            print(myApps)
        }
        catch let error as NSError
        {
            //print ("in error")
            print("Could not fetch \(error), \(error.userInfo)")
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myApps.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCurrentAppsCell", forIndexPath: indexPath)

        cell.textLabel?.text = myApps[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            var appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
            context = appDel.managedObjectContext
            
            let fetchRequest = NSFetchRequest(entityName: "BusinessApps")
            do
            {
                let results:NSArray = try context!.executeFetchRequest(fetchRequest)
                
                for var i = 0; i < results.count; i++
                {
                    if myApps[indexPath.row] == results[i].valueForKey("businessApp") as! String! {
                        print(results[i].valueForKey("businessApp") as! String!)
                        context!.deleteObject(results[i].valueForKey("businessApp") as! NSManagedObject)
                    }
                    
                }
                print(myApps)
            }
            catch let error as NSError
            {
                //print ("in error")
                print("Could not fetch \(error), \(error.userInfo)")
            }

            print(myApps[indexPath.row])
            myApps.removeAtIndex(indexPath.row)
            print(myApps[indexPath.row])
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            /*let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let moc = appDelegate.managedObjectContext
            
            // 3
            moc.deleteObject(myApps[indexPath.row])
            appDelegate.saveContext()
            
            // 4
            myApps.removeAtIndex(indexPath.row)
            tableView.reloadData()
            */
            
            /*var appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
            let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
            let context:NSManagedObjectContext = appDel.managedObjectContext
            context.deleteObject(myApps[indexPath.row] as! NSManagedObject)
            myApps.removeAtIndex(indexPath.row)
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                    abort()
                }
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
*/
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let destViewController : NewAppAreaSelectionTableViewController = segue.destinationViewController as! NewAppAreaSelectionTableViewController
        destViewController.myApps = myApps
        
    }
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
