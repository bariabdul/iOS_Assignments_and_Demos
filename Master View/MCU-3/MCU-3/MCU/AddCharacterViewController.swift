//
//  AddCharacterViewController.swift
//  MCU
//
//  Created by Kurt McMahon on 10/16/16.
//  Copyright © 2016 Northern Illinois University. All rights reserved.
//

import UIKit

class AddCharacterViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    // MARK: Properties
    
    let pickerViewOptions = ["Avengers", "Defenders", "Guardians of the Galaxy", "Independent"]
    let pickerView: UIPickerView! = UIPickerView()
    
    var character: MCUCharacter?
    
    // MARK: Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var realNameTextField: UITextField!
    @IBOutlet weak var allegianceTextField: UITextField!
    
    // MARK: UIViewController methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        setUpPickerView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpPickerView() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        let doneButton = UIBarButtonItem(title: "Select", style: UIBarButtonItemStyle.Done, target: self, action: #selector(AddCharacterViewController.selectItem))
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([space, doneButton], animated: false)
        
        pickerView.showsSelectionIndicator = true;
        pickerView.delegate = self
        pickerView.dataSource = self
        
        allegianceTextField.inputAccessoryView = toolBar
        allegianceTextField.inputView = pickerView
    }
    
    func selectItem() {
        allegianceTextField.endEditing(true)
    }
    
    // MARK: UITableViewDelegate methods
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            nameTextField.becomeFirstResponder()
        }
        if indexPath.section == 1 {
            realNameTextField.becomeFirstResponder()
        }
        if indexPath.section == 2 {
            allegianceTextField.becomeFirstResponder()
        }
    }

    // MARK: Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SaveCharacter" {
            character = MCUCharacter(name: nameTextField.text!, realName: realNameTextField.text!, allegiance: allegianceTextField.text!, url: "None")
        }
    }
    
    // MARK: UIResponder methods
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: UITextFieldDelegate methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: UIPickerView methods
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewOptions.count
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewOptions[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        allegianceTextField.text = pickerViewOptions[row]
    }
}
