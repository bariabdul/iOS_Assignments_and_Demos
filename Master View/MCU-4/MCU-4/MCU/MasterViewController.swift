//
//  MasterViewController.swift
//  MCU
//
//  Created by Kurt McMahon on 10/13/16.
//  Copyright © 2016 Northern Illinois University. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    // MARK: Properties
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var detailViewController: DetailViewController? = nil
    var objects = [MCUCharacter]()
    var filteredObjects = [MCUCharacter]()

    // MARK: UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        downloadData()
        
        // Create search controller and set up search bar and scope bar
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.delegate = self
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.scopeButtonTitles = ["All", "Avengers", "Defenders", "Independent"]
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

    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredObjects = objects.filter { character in
            let categoryMatch = (scope == "All") || (character.allegiance == scope)
            return categoryMatch && character.name.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
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

    
    @IBAction func unwindToCancel(segue: UIStoryboardSegue) {
    }

    @IBAction func unwindToSave(segue: UIStoryboardSegue) {
        if let addCharacterViewController = segue.sourceViewController as? AddCharacterViewController {
            
            //add the new character to the objects array
            if let character = addCharacterViewController.character {
                //objects.append(character)
                
                //update the tableView
                var index = objects.indexOf({$0.name > character.name})
                if index == nil {
                    index = objects.count
                }
                
                objects.insert(character, atIndex: index!)
                
                let indexPath = NSIndexPath(forRow: index!, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }

    // Download JSON data
    func downloadData() {
        
        let session = NSURLSession.sharedSession()
        
        guard let url = NSURL(string: "https://www.prismnet.com/~mcmahon/CS321/characters.json") else {
            // Perform some error handling
            showAlert("Invalid URL for JSON data.")
            return
        }
        
        weak var weakSelf = self
        
        let task = session.dataTaskWithURL(url) {
            (data, response, error) in
            // The response is a NSHTTPURLResponse, so the app should check for unexpected // status codes
            let httpResponse = response as? NSHTTPURLResponse
            
            if httpResponse!.statusCode != 200 {
                weakSelf!.showAlert("HTTP Error: status code \(httpResponse!.statusCode).")
            } else if (data == nil && error != nil) {
                weakSelf!.showAlert("No data downloaded.")
            } else {
                // Download succeeded
                let array: [AnyObject]
                
                do {
                    array = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [AnyObject]
                } catch _ {
                    weakSelf!.showAlert("Unable to parse JSON data.")
                    return
                }

                for dictionary in array {
                    let name = dictionary["Name"] as! String
                    let realName = dictionary["Real Name"] as! String
                    let allegiance = dictionary["Allegiance"] as! String
                    let url = dictionary["URL"] as! String
                    
                    weakSelf!.objects.append(MCUCharacter(name: name, realName: realName, allegiance: allegiance, url: url))
                }

                weakSelf!.objects.sortInPlace {
                    return $0.name < $1.name
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    weakSelf!.tableView!.reloadData()
                }
            }
        }
        
        task.resume()
    }
    
    func showAlert(message: String) {
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        dispatch_async(dispatch_get_main_queue()) {
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: UITableViewDataSource methods

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredObjects.count
        }

        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MCUCharacterCell

        let character: MCUCharacter
        if searchController.active && searchController.searchBar.text != "" {
            character = filteredObjects[indexPath.row]
        } else {
            character = objects[indexPath.row]
        }
        
        ImageProvider.sharedInstance.imageWithURLString(character.url) {
            (image) in
            cell.characterImageView.image = image
        }
        
        cell.nameLabel!.text = character.name
        cell.allegianceLabel!.text = character.allegiance
        
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

    // MARK: UISearchResultsUpdating methods
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }

    // MARK: UISearchBarDelegate methods

    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }


}

