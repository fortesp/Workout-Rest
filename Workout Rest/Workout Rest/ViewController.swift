//
//  ViewController.swift
//  Workout Rest
//
//  Created by Pedro Fortes on 31/10/15.
//  Copyright © 2015 Pedro Fortes. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    @IBOutlet weak var viewLabelTimer: UILabel!
    @IBOutlet weak var viewButtonSwitch: UIButton!
    @IBOutlet weak var viewSlider: UISlider!
    @IBOutlet weak var viewSliderLabelLegend: UILabel!
    
    var countFraction = 0, totalSeconds = 0, totalMinutes = 0
    var startTime = NSTimeInterval();
    var timer: NSTimer!
    var limitTimeSeconds = 20
    var limitOffsetSeconds = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTime() {
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime: NSTimeInterval = currentTime - startTime;
        
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        let fraction = UInt8(elapsedTime * 100);
        
        
        if (minutes > 0) {
            totalSeconds = Int(seconds * minutes)
        } else { totalSeconds = Int(seconds) }
        
        
        NSLog(String(totalSeconds) + "---" + String(limitTimeSeconds))
        
        if(Int(totalSeconds)==Int(limitTimeSeconds)) {
            
            self.view.backgroundColor = UIColor.redColor();
            
            if(fraction==0) {
                
                let animation = CABasicAnimation(keyPath: "transform.scale")
                animation.toValue = NSNumber(float: 1.7)
                animation.duration = 0.2
                animation.repeatCount = 0
                animation.autoreverses = true
                
                
                self.viewLabelTimer.layer.addAnimation(animation, forKey: nil)
               
                
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        }
        
        if(Int(totalSeconds) > Int(limitTimeSeconds + limitOffsetSeconds)) {
            self.view.backgroundColor = UIColor.lightGrayColor();
        }
        
        setViewLabelTime("\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds)):\(String(format: "%02d", fraction))");
        
    }
    
    func setViewLabelTime(strTime: String) {
        
        self.viewLabelTimer.text=strTime;
    }
    
    @IBAction func viewButtonSwitchAction(sender: UIButton) {
        
        if(timer == nil || !timer.valid) {
            
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateTime", userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
            
        } else {
            
            timer.invalidate();
            self.view.backgroundColor = UIColor.whiteColor();
            setViewLabelTime("00:00:00");
        }
        
    }

    @IBAction func viewSliderAction(sender: UISlider) {
        
        
        switch(self.viewSlider.value) {
        
         case 0..<0.5:
                        self.viewSlider.value = 0
                        self.viewSliderLabelLegend.text = "20 seconds"
                        limitTimeSeconds = 20
            
         case 0.5..<1.5:
                        self.viewSlider.value = 1
                        self.viewSliderLabelLegend.text = "40 seconds"
                        limitTimeSeconds = 40
            
         case 1.5..<2.5:
                        self.viewSlider.value = 2
                        self.viewSliderLabelLegend.text = "1 minute"
                        limitTimeSeconds = 60
        
         case 2.5..<3.5:
                        self.viewSlider.value = 3
                        self.viewSliderLabelLegend.text = "2 minutes"
                        limitTimeSeconds = 120
        
         case 3.5..<4.5:
                        self.viewSlider.value = 4
                        self.viewSliderLabelLegend.text = "3 minutes"
                        limitTimeSeconds = 180

        case 4.5..<5.5:
                        self.viewSlider.value = 5
                        self.viewSliderLabelLegend.text = "4 minutes"
                        limitTimeSeconds = 240
       
        case 5.5..<6:
                        self.viewSlider.value = 6
                        self.viewSliderLabelLegend.text = "5 minutes"
                        limitTimeSeconds = 300
             
         
          default: self.viewSlider.value = 6
        }
        
        
    }
}

