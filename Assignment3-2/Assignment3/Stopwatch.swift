//
//  Stopwatch.swift
//  Assignment3
//
//  Created by Bari Abdul on 10/23/16.
//  Copyright © 2016 Bari Abdul. All rights reserved.
//

import UIKit

class Stopwatch : UIViewController {

    var pauseButtonCounter = 0          //declare all the necessary variables
    var time = NSTimer()
    var t1 = 0.0
    var savedValue = 0.0
    
    @IBOutlet weak var ClockOutlet: UIDatePicker!           //declare all the necessary outlets and actions and buttons
    
    @IBOutlet weak var Timer: UILabel!
    
    @IBOutlet weak var startButton: UIBarButtonItem!
   
    @IBOutlet weak var stopButton: UIBarButtonItem!
    
    @IBOutlet weak var pauseButton: UIBarButtonItem!
    
    @IBAction func pauseButtonAction(sender: UIBarButtonItem) {         //this is the functionality for the pause button
        
        startButton.enabled = true
        stopButton.enabled = false
        
        //as per the logic, the stop button is supposed to be hidden when pause is pressed
        pauseButton.enabled = true
        savedValue = t1         //save th current timer in saved value
        
        pauseButtonCounter += 1         //this is a counter to count the number of times the pause button is pressed so that the functionality for the pause button is carried throughout the program
        if pauseButtonCounter % 2 == 0 {
            time =  NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(decrementClock), userInfo: nil, repeats: true)
            //this is an instance of NSTimer
            stopButton.enabled = true
            startButton.enabled = false
        }
            
        else {
            time.invalidate()
        }
    }
    
    
    @IBAction func playButtonAction(sender: UIBarButtonItem) {          //this is the functionality for the play button
        
        //as per the logic, when play is pressed, play should be disabled and rest two buttons enabled
        startButton.enabled = false
        stopButton.enabled = true
        pauseButton.enabled = true
        
        time =  NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(decrementClock), userInfo: nil, repeats: true)
        
        if t1 == 0.0 {          //set the clock time property
            t1 = self.ClockOutlet.countDownDuration
        }
            
        else {
            pauseButtonCounter += 1
            t1 = savedValue
        }
    }
    
    
    @IBAction func stopButtonAction(sender: UIBarButtonItem) {          //this is the functionality for the stop button
        
        //as per the logic, when stop is pressed, the play button should be enabled and rest two disabled
        stopButton.enabled = false
        startButton.enabled = true
        pauseButton.enabled = false
        
        time.invalidate()       //invalidate the timer when stop is pressed and set t1 to 0
        t1 = 0.0
        
        //when the stop button is pressed, as the counter is set to 0, display the same
        var strDefault: String
        strDefault = String(format: "%02d:%02d", 0, 0)
        
        Timer.text = strDefault
    }
    
    //this function converts seconds to seconds
    func SecToSeconds(seconds : Int) -> Int {
        return ((seconds % 3600) % 60)
    }
    
    //this function converts seconds to minutes
    func SecToMinutes(seconds : Int) -> Int {
        return ((seconds % 3600) / 60)
    }
    
    //this function converts seconds to hours
    func SecToHours(seconds : Int) -> Int {
        return (seconds / 3600)
    }
    
    //this function decements the counter until 0 is reached
    func decrementClock() {
        
        //store the value of hours, minutes and seconds
        let hours = SecToHours(Int(t1))
        let minutes = SecToMinutes(Int(t1))
        let seconds = SecToSeconds(Int(t1))
        
        var str: String
        
        switch(hours) {         //this switch statement is responsible for displaying the proper format of counter if h is 0 and if h is not 0
        case 0 : str = String(format: "%02d:%02d", minutes, seconds)
        default : str = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
        
        Timer.text = str
        
        if t1 == 0.0 {          //if timer reaches 0, invalidate the time and set the play button to enabled
            time.invalidate()
            
            stopButton.enabled = false
            pauseButton.enabled = false
            startButton.enabled = true
        }
        
        t1 -= 1     //keep decrementing the timer
     }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pauseButton.enabled = false
        stopButton.enabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //this code is used for having all kinds of orientations including the upside down
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return.All
    }


}

