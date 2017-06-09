//
//  MasterViewController.swift
//  Assignment4
//
//  Created by Bari Abdul and Abdul Subhan Moin Syed on 11/2/16.
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
        downloadData()
        
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

        //this is used to clear the cache
        let clearCache = ImageProvider()
        clearCache.clearCache()
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
                
                let president: President
                if searchController.active && searchController.searchBar.text != "" {
                    president = filteredObjects[indexPath.row]
                } else {
                    president = objects[indexPath.row]
                }
                
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = president
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    
    //this function reads and stores the dictionary values. I also did add Donald Trump to the presidents.plist as the 45th president, but as of now images are beign loaded from a URL.
    func downloadData() {
        
        let session = NSURLSession.sharedSession()
        
        guard let url = NSURL(string: "https://www.prismnet.com/~mcmahon/CS321/presidents.json") else {
            //Perform some error handling
            showAlert("Invalid URL for JSON data.")
            return
        }
        
        weak var weakSelf = self
        
        let task = session.dataTaskWithURL(url) {
            (data, response, error) in
            //The response is a NSHTTPURLResponse, so the app should check for unexpected // status codes
            let httpResponse = response as? NSHTTPURLResponse
            
            if httpResponse!.statusCode != 200 {
                weakSelf!.showAlert("HTTP Error: status code \(httpResponse!.statusCode).")
            } else if (data == nil && error != nil)
            {
                weakSelf!.showAlert("No data downloaded.")
            } else {
                //Download succeeded
                let array: [AnyObject]
                
                do {
                    array = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [AnyObject]
                } catch _ {
                    weakSelf!.showAlert("Unable to parse JSON data.")
                    return
                }
                
                for dictionary in array {
                    let name = dictionary["Name"] as! String
                    let number = dictionary["Number"] as! Int
                    let startDate = dictionary["Start Date"] as! String
                    let endDate = dictionary["End Date"] as! String
                    let nickname = dictionary["Nickname"] as! String
                    let politicalParty = dictionary["Political Party"] as! String
                    let url = dictionary["URL"] as! String
                    
                    weakSelf!.objects.append(President(name: name, number: number, startDate: startDate, endDate: endDate, nickname: nickname, politicalParty: politicalParty, url: url))
                }
                
                //sort in ascending order of their presidentship
                weakSelf!.objects.sortInPlace {
                    return $0.number < $1.number
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    weakSelf!.tableView!.reloadData()
                }
            }
        }
        
        task.resume()
    }
    
    //this is in case an error occurs, allowing user to select one of the buttons
    func showAlert(message: String) {
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        dispatch_async(dispatch_get_main_queue()) {
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }

    // MARK: - UITableViewDataSource methods

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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PresidentCell

        let pres: President
        if(searchController.active && searchController.searchBar.text != "") {      //this loop helps in returning the filtered names or the whole list of names
            pres = filteredObjects[indexPath.row]
        }
 
        else {
        pres = objects[indexPath.row]
        }
        
        ImageProvider.sharedInstance.imageWithURLString(pres.url) {
            (image) in
            cell.presidentImageView.image = image
        }
        
        //for every cell print the name and the party to which the president belongs
        cell.nameLabel!.text = pres.name
        cell.politicalPartyLabel!.text = pres.politicalParty
        
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