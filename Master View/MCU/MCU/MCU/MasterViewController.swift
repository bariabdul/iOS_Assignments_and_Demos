//
//  MasterViewController.swift
//  MCU
//
//  Created by Kurt McMahon on 10/13/16.
//  Copyright © 2016 Northern Illinois University. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    // MARK: Properties
    
    var detailViewController: DetailViewController? = nil
    var objects = [MCUCharacter]()

    // MARK: UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        //let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(insertNewObject(_:)))
        //self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        objects.append(MCUCharacter(name: "Iron Man", realName: "Tony Stark", allegiance: "Avengers"))
        objects.append(MCUCharacter(name: "Captain America", realName: "Steve Rogers", allegiance: "Avengers"))
        objects.append(MCUCharacter(name: "Falcon", realName: "Samuel \"Sam\" Wilson", allegiance: "Avengers"))
        objects.append(MCUCharacter(name: "Black Widow", realName: "Natalia \"Natasha\" Romanova", allegiance: "Avengers"))
        objects.append(MCUCharacter(name: "Scarlet Witch", realName: "Wanda Maximoff", allegiance: "Avengers"))
        objects.append(MCUCharacter(name: "Spider-Man", realName: "Peter Parker", allegiance: "Independent"))
        objects.append(MCUCharacter(name: "Punisher", realName: "Frank Castle", allegiance: "Independent"))
        objects.append(MCUCharacter(name: "Daredevil", realName: "Matthew Murdock", allegiance: "Defenders"))
        objects.append(MCUCharacter(name: "Luke Cage", realName: "Carl Lucas", allegiance: "Defenders"))
        objects.append(MCUCharacter(name: "Jessica Jones", realName: "Jessica Jones", allegiance: "Defenders"))
        
        objects.sortInPlace({
            return $0.name < $1.name
        })
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
                controller.navigationItem.title = object.name
            }
        }
    }

    // MARK: UITableViewDataSource methods

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object.name
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

