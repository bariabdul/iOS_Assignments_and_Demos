//
//  MasterViewController.swift
//  Assignment4
//
//  Created by Bari Abdul on 11/2/16.
//  Copyright © 2016 Bari Abdul. All rights reserved.
//

import UIKit

//extend all the necesary classes
class MasterViewController: UITableViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    //decalre the necessary variables/arrays
    let searchController = UISearchController(searchResultsController: nil)
    
    var detailViewController: DetailViewController? = nil
    var objects = [President]()
    var filteredObjects = [President]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        //this function is responsible to get data from the dictionary
        readPropertyList()
        
        //Create search controller and set up search and scope bar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.delegate = self
        
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchBar.scopeButtonTitles = ["All", "Democrat", "Republican", "Whig"]
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
    }
    

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //this function is responsible for filtering the presidents names as typed in the search bar
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredObjects = objects.filter { character in
            let categoryMatch = (scope == "All") || (character.politicalParty == scope)
            return categoryMatch && character.name.lowercaseString.containsString(searchText.lowercaseString)
    }
        tableView.reloadData()
    }


    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    
    //this function reads and stores the dictionary values. I also did add Donald Trump to the presidents.plist as the 45th president.
    func readPropertyList() {
    let plistURL = NSBundle.mainBundle().URLForResource("presidents", withExtension: ".plist")
        let array = NSArray(contentsOfURL: plistURL!) as! [AnyObject]
        
        for dictionary in array {
            let name = dictionary["Name"] as! String
            let number = dictionary["Number"] as! Int
            let startDate = dictionary["Start Date"] as! String
            let endDate = dictionary["End Date"] as! String
            let nickname = dictionary["Nickname"] as! String
            let politicalParty = dictionary["Political Party"] as! String
            
            //add all the presidents into the array objects
            objects.append(President(name: name, number: number, startDate: startDate, endDate: endDate, nickname: nickname, politicalParty: politicalParty))
        }
        
        //sort in ascending order of the presidentship
        objects.sortInPlace {
            return $0.number < $1.number
        }
    }
    

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchController.active && searchController.searchBar.text != "") {
            return filteredObjects.count
        }
        
        return objects.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let pres: President
        if(searchController.active && searchController.searchBar.text != "") {      //this loop helps in returning the filtered names or the whole list of names
            pres = filteredObjects[indexPath.row]
        }
 
        else {
        pres = objects[indexPath.row]
        }
        
        //for every cell print the name and the party to which the president belongs
        cell.textLabel!.text = pres.name
        cell.detailTextLabel!.text = pres.politicalParty
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
    
    
    //for updating the search results
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
    
    
    //it tells the delegate that the scope button selection changed
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
            tableView.reloadData()
    }
    
    
    //this code is used for having all kinds of orientations including the upside down
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return.All
    }


}