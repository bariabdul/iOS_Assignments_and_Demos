//
//  Temperature.swift
//  Assignment3
//
//  Created by Bari Abdul on 10/23/16.
//  Copyright © 2016 Bari Abdul. All rights reserved.
//

import UIKit

class Temperature: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var fahrenheitTemps = Array(-129...134)         //declare the two arrays to hold the temperature values
    var celsiusTemps = Array(-90...57)
    
    @IBOutlet weak var singlePicker: UIPickerView!          //declare all the necessary labels and views
    @IBOutlet weak var temp: UISegmentedControl!
    @IBOutlet weak var converter: UILabel!
    
    @IBAction func converter(sender: UISegmentedControl) {      //this segmented control is responsible to have two tabs and also to load data from data source which are the two arrays depending on which segment is selected
        
       singlePicker.reloadAllComponents()
       
        if(temp.selectedSegmentIndex == 0) {            //display the appropriate converted value for the row selected in the first segment
            let celsius = (Double(fahrenheitTemps[singlePicker.selectedRowInComponent(0)]-32)/1.8)
            
            let formatter = NSNumberFormatter()
            formatter.numberStyle = NSNumberFormatterStyle.NoStyle
            
            let formattedCelsius = formatter.stringFromNumber(celsius)!
            
            converter.text = "\(formattedCelsius) °C"
        }
            
        else {          //display the appropriate converted value for the row selected in the second segment
            converter.text = "\(fahrenheitTemps[0]) °F"
            let fahrenheit = (Double(celsiusTemps[singlePicker.selectedRowInComponent(0)])*1.8+32.0)
            
            let formatter = NSNumberFormatter()
            formatter.numberStyle = NSNumberFormatterStyle.NoStyle
            
            let formattedFahrenheit = formatter.stringFromNumber(fahrenheit)!
            
            converter.text = "\(formattedFahrenheit) °F"
        }
 
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //by default select the first row after the app is launched
        singlePicker.dataSource = self
        pickerView(singlePicker, didSelectRow: 0, inComponent: 0)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //this code is used for having all kinds of orientations including the upside down
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return.All
    }
    
    
    // MARK: UIPickerViewDataSource methods
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(temp.selectedSegmentIndex == 0) {
        return fahrenheitTemps.count
        }
        
        else {
            return celsiusTemps.count
        }
    }
    
    // MARK: UIPickerViewDelegate methods
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(temp.selectedSegmentIndex == 0) {
            return "\(fahrenheitTemps[row]) °F"
        }
        
        else {
            return "\(celsiusTemps[row]) °C"
        }
    }
    
    
   func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {           //this method does the conversion part and this is also present in the segmented control as well
    
        if(temp.selectedSegmentIndex == 0) {
        
        let celsius = (Double(fahrenheitTemps[row]-32)/1.8)     //this is the conversion formula for fahrenheit to celsius
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.NoStyle
        
        let formattedCelsius = formatter.stringFromNumber(celsius)!     //converting the number to string
        
        converter.text = "\(formattedCelsius) °C"
        }
        
        else {
        let fahrenheit = (Double(celsiusTemps[row])*1.8+32.0)           //this is the conversion formula for celsius to fahrenheit
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.NoStyle
        
        let formattedFahrenheit = formatter.stringFromNumber(fahrenheit)!       //converting the number to string
        
        converter.text = "\(formattedFahrenheit) °F"
        }
    }



}

