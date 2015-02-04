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
    @IBOutlet weak var answerABtn: WKInterfaceButton!
    @IBOutlet weak var answerBBtn: WKInterfaceButton!
    @IBOutlet weak var feedbackTxtLabel: WKInterfaceLabel!
    
    
    let qManager = QuestionManagerModel()
    // Keep track of whether there's a pending update
    var updating = false
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        displayQuestion()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    private func updateQuestion() {
        if !updating {
            updating = true
            var qText: String
            var qOpts: [String]
            var qAnswerIndex: Int
            (qText, qOpts, qAnswerIndex) = qManager.getNewQuestion()
            displayQuestionUI(qText, qOpts: qOpts)
            self.updating = false
        }
    }

    private func displayQuestion() {
        var qText: String
        var qOpts: [String]
        var qAnswerIndex: Int
        (qText, qOpts, qAnswerIndex) = qManager.getCachedQuestion()
        displayQuestionUI(qText, qOpts: qOpts)
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

    

    @IBAction func answerATapped() {
        evaluateResponse(0)
    }

    @IBAction func answerBTapped() {
        evaluateResponse(1)
    }

    func evaluateResponse(chosenOptionIndex: Int) {
        feedbackTxtLabel.setText(qManager.getFeedbackText(chosenOptionIndex))
        
        // Hide question details
        questionTxtLabel.setHidden(true)
        answerABtn.setHidden(true)
        answerBBtn.setHidden(true)
        
        // Show feedback text
        feedbackTxtLabel.setHidden(false)
        
        // Display feedback for 2 seconds, then display a new question
        //timer = NSTimer.scheduledTimerWithTimeInterval(2, target:self, selector: Selector("updateQuestion"), userInfo: nil, repeats: false)
        
    }
    
    
    
}
