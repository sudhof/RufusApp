//
//  ViewController.swift
//  RufRuf
//
//  Created by Momo Sudplant on 2/2/15.
//  Copyright (c) 2015 Fatherstone Zenithpeak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var questionTxtLabel : UILabel!
    @IBOutlet var feedbackLabel : UILabel!
    @IBOutlet var optAButton : UIButton!
    @IBOutlet var optBButton : UIButton!
    @IBOutlet var optCButton : UIButton!
    @IBOutlet var refreshButton : UIButton!
    
    let qManager = QuestionManagerModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func refreshUI() {

        var qText: String
        var qOpts: [String]
        var qAnswerIndex: Int
        (qText, qOpts, qAnswerIndex) = qManager.getNewQuestion()
        
        questionTxtLabel.text = qText
        optAButton.setTitle(qOpts[0], forState: UIControlState.Normal)
        optBButton.setTitle(qOpts[1], forState: UIControlState.Normal)
        optCButton.setTitle(qOpts[2], forState: UIControlState.Normal)
        feedbackLabel.text = ""
        
    }
    
    @IBAction func refreshTapped(sender : AnyObject) {
        refreshUI()
    }
    
    @IBAction func optATapped(sender : AnyObject) {
        evaluateResponse(0)
    }
    
    @IBAction func optBTapped(sender : AnyObject) {
        evaluateResponse(1)
    }
    
    @IBAction func optCTapped(sender : AnyObject) {
        evaluateResponse(2)
    }
    
    func evaluateResponse(chosenOptionIndex: Int) {
        feedbackLabel.text = qManager.getFeedbackText(chosenOptionIndex)
    }
    
    
    
    
    
}

