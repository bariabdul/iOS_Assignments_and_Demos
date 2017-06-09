//
//  ViewController.swift
//  Weather
//
//  Created by Kurt McMahon on 10/30/16.
//  Copyright © 2016 Northern Illinois University. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    // MARK: Outlets
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    // MARK: UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: ViewController methods
    
    @IBAction func findWeather(sender: UIButton) {
        
        var wasSuccessful = false
    
        guard let cityName = cityTextField.text where !cityName.isEmpty else {
            resultLabel.text = "Please enter a city name."
            return
        }
        
        guard let url = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest") else {
            resultLabel.text = "Couldn't find the weather for that city - please try again."
            return
        }
        
        weak var weakSelf = self
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
            (data, response, error) in
            
            let httpResponse = response as? NSHTTPURLResponse
            
            if httpResponse!.statusCode != 200 {
                print("HTTP Error: status code \(httpResponse!.statusCode).")
            } else if (data == nil && error != nil) {
                print("No data downloaded.")
            } else {
                
                let webContent = NSString(data: data!, encoding: NSUTF8StringEncoding)
                
                let websiteArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if websiteArray.count > 1 {
                    let weatherArray = websiteArray[1].componentsSeparatedByString("</span>")
                    
                    if weatherArray.count > 0 {
                        
                        wasSuccessful = true
                        
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º ")
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            weakSelf!.resultLabel.text = weatherSummary
                        })
                    }
                }
                
            }
            
            if !wasSuccessful {
                dispatch_async(dispatch_get_main_queue(), {
                    weakSelf!.resultLabel.text = "Couldn't find the weather for that city - please try again."
                })
            }
        }
        task.resume()
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
}

