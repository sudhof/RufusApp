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
            questionTxtLabel.setText(qText)
            answerABtn.setTitle(qOpts[0])
            answerBBtn.setTitle(qOpts[1])
            self.updating = false
        }
    }
    
    private func displayQuestion() {
        var qText: String
        var qOpts: [String]
        var qAnswerIndex: Int
        (qText, qOpts, qAnswerIndex) = qManager.getCachedQuestion()
        questionTxtLabel.setText(qText)
        answerABtn.setTitle(qOpts[0])
        answerBBtn.setTitle(qOpts[1])
    }
    

    @IBAction func answerATapped() {
        // currently not checking answers, 
        // just displaying a new question
        updateQuestion()
    }

    @IBAction func answerBTapped() {
        updateQuestion()
    }

}
