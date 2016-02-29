//
//  ViewController.swift
//  YouTubeTutorial
//
//  Created by Celena Haase on 1/5/16.
//  Copyright © 2016 Celena Haase. All rights reserved.
//
//  To Do
//  1) Make a timer with start and stop.
//  2) Allow users to create photos that inspire them.
//  3) Allow users to set the time.
//  4) Have a random feature that picks tasks
//     or let user set the task priority for more user control.
//  5) Play sound when allocated time for task is up
//  6) Make a brief youtube tutorial about why I created it.

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    @IBOutlet weak var secondCardImageView: UIImageView!
    
    @IBOutlet weak var playRoundButton: UIButton!
    
    @IBOutlet weak var newYearsRez: UILabel!
    var tasksUsersChoose:String = ""
    
    @IBOutlet weak var playerScoreLabel: UILabel!
    var playerScore:Int = 0
    
    @IBOutlet weak var TaskCounterLabel: UILabel!

    var taskTimer:Int = 0
    
    var taskNumber:Int = -1
    
    var timer = NSTimer()
  
    func PriorityCounting(){
        if self.taskNumber < 8
        {
            self.taskNumber += 1
        }
    }

    func Counting(){
        
       self.taskTimer -= 1
       var elapsedTime:Int = self.taskTimer
       let minutes = self.taskTimer / 60
       elapsedTime -= minutes * 60
       let seconds = elapsedTime
       let strMinutes = String(format: "%02d", minutes)
       let strSeconds = String(format: "%02d", seconds)
       self.TaskCounterLabel.text = "\(strMinutes):\(strSeconds)"
        
    
        if self.taskTimer < 1 {
            self.timer.invalidate()
            
            //sound code
            let myFilePathString = NSBundle.mainBundle().pathForResource("orchestra_tuning", ofType: "wav")
           
            if let myFilePathString = myFilePathString
            {
                let myFilePathURL = NSURL(fileURLWithPath: myFilePathString)
                do {
                    
                    try myAudioPlayer = AVAudioPlayer(contentsOfURL: myFilePathURL)
                    myAudioPlayer.play()
                    //play then stop and exit
                    //myAudioPlayer.stop()
                } catch{
                    print("error")
                }
            } //only go through this once

        } //end taskTimer loop

    } //end func Counting

    
    var cardNamesArray:[String]=["cardback","card1","card2","card3","card4","card5","card6","card7","card8","card9","card10","card11","card12","card13","card14","card15","card16","card17","card18","card19","card20","card21","card22","card23","card24","card25","card26"]
    
    var taskOnlyTextArray: //start the day then hour chunks
        [String]=["Ready?","30 min on goals","30 min workout","30 min on some errands","30 min on making money","30 min respond to email","30 min on keeping track of money","30 min on relationships"]

    
    var myAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.playRoundButton.setTitle("Start", forState: UIControlState.Normal)
          }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func playRoundTapped(sender: UIButton) {
  
        //stop timer from previous round
        self.timer.invalidate()
        
        var timerRunning = false
        
        self.PriorityCounting()
       
        let secondCardString:String = self.cardNamesArray[taskNumber]
        
        self.secondCardImageView.image = UIImage(named: secondCardString)
        
        tasksUsersChoose = self.taskOnlyTextArray[taskNumber]
       
        self.newYearsRez.text = String(self.tasksUsersChoose)
        
        
        if  taskNumber > 0
        {
            self.playerScore += 1
            
            self.playerScoreLabel.text = String(self.playerScore)

            self.taskTimer = 1800 //3600 is one hour
            if timerRunning == false {

            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:("Counting"), userInfo: nil, repeats: true)
            timerRunning = true }
       
        }
      
    }
}


