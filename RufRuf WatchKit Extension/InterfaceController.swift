//
//  InterfaceController.swift
//  RufRuf WatchKit Extension
//
//  Created by Momo Sudplant on 2/3/15.
//  Copyright (c) 2015 Fatherstone Zenithpeak. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {



    @IBOutlet weak var questionTxtLabel: WKInterfaceLabel!
    @IBOutlet weak var feedbackTxtLabel: WKInterfaceLabel!
    @IBOutlet weak var answerBBtn: WKInterfaceButton!
    @IBOutlet weak var answerABtn: WKInterfaceButton!
    
    let qManager = QuestionManagerModel()
    // Keep track of whether there's a pending update
    var updating = false
    var timer = NSTimer()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        updateQuestion()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func answerATapped() {
        evaluateResponse(0)
    }
    
    @IBAction func answerBTapped() {
        evaluateResponse(1)
    }
    
    func updateQuestion() {
        if !updating {
            updating = true
            qManager.requestQuestion { (prompt, options, error) -> () in
                if error? == nil {
                    self.displayQuestionUI(prompt!, qOpts: options)
                    self.updating = false
                }
            }
        }
    }

    
    private func displayQuestionUI(qText: String, qOpts: [String]) {
        // Update UI text:
        questionTxtLabel.setText(qText)
        answerABtn.setTitle(qOpts[0])
        answerBBtn.setTitle(qOpts[1])
        // Show question UI elems:
        questionTxtLabel.setHidden(false)
        answerABtn.setHidden(false)
        answerBBtn.setHidden(false)
        // Hide feedback UI elem:
        feedbackTxtLabel.setHidden(true)
    }

    

    func evaluateResponse(chosenOptionIndex: Int) {
        feedbackTxtLabel.setText(qManager.getFeedbackText(chosenOptionIndex))
        
        // Hide question details
        questionTxtLabel.setHidden(true)
        answerABtn.setHidden(true)
        answerBBtn.setHidden(true)
        
        // Show feedback text
        feedbackTxtLabel.setHidden(false)
        
        // Display feedback for 3 seconds, then display a new question
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target:self, selector: Selector("updateQuestion"), userInfo: nil, repeats: false)
        
    }
    
    
    
}
