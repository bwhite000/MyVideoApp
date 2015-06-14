//
//  VideoTableViewController.swift
//  MyVideoApp
//
//  Created by Brandon White on 6/13/15.
//  Copyright (c) 2015 Rock Valley College. All rights reserved.
//

import UIKit
//1) Imports
import MediaPlayer
import MobileCoreServices
import AVFoundation
import CoreData
import Foundation

class VideoTableViewController: UITableViewController {
    
    //2) Add variable to hold NSManagedObject
    var photoArray = [NSManagedObject]()

    //4) Create action of btnBack with code to go back
    @IBAction func btnBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    //3) Create viewDidAppea with loaddb()
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        loaddb()
    }
    
    //5) Add func loaddb to load database and refresh table
    func loaddb()
    {
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName:"Video")
        
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as! [NSManagedObject]?
        
        if let results = fetchedResults {
            photoArray = results
            tableView.reloadData()
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        
        //6) Change to 1
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        
        //7 Change to return photoArray.count
        return photoArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //8) Uncomment & Change to below to load rows
        let cell =
        tableView.dequeueReusableCellWithIdentifier("Cell")
            as! UITableViewCell
        
        let person = photoArray[indexPath.row]
        cell.textLabel?.text = person.valueForKey("name") as! String?
        
        return cell
    }
    
    //9) Add to show row clicked
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)")
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //10 Uncomment & Change to delete swiped row
        if editingStyle == .Delete {
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            let context = appDelegate.managedObjectContext!
            context.deleteObject(photoArray[indexPath.row])
            var error: NSError? = nil
            if !context.save(&error) {
                println("Unresolved error \(error)")
                abort()
            }
            else
            {
                loaddb()
            }
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    //11) Uncomment & Change to go to proper record on proper Viewcontroller
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "video" {
            if let destination = segue.destinationViewController as?
                ViewController {
                    if let SelectIndex = tableView.indexPathForSelectedRow()?.row {
                        
                        let selectedDevice:NSManagedObject = photoArray[SelectIndex] as NSManagedObject
                        destination.videodb = selectedDevice
                    }
            }
        }
    }

}
