//
//  ViewController.swift
//  RufRuf
//
//  Created by Momo Sudplant on 2/2/15.
//  Copyright (c) 2015 Fatherstone Zenithpeak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var questionTxtLabel : RDLabel!
    @IBOutlet var feedbackLabel : RDLabel!
    @IBOutlet var optAButton : UIButton!
    @IBOutlet var optBButton : UIButton!
    @IBOutlet var refreshButton : UIButton!
    @IBOutlet weak var bannerImg: UIImageView!
    
    let qManager = QuestionManagerModel()
    
    var banner_imgs = [UIImage(named: "banner1"), UIImage(named: "banner2"), UIImage(named: "banner3"), UIImage(named: "banner4"), UIImage(named: "banner5"), UIImage(named: "banner6"), UIImage(named: "banner7"), UIImage(named: "banner8"), UIImage(named: "banner9")]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.questionTxtLabel.layer.cornerRadius = 5
        self.questionTxtLabel.clipsToBounds = true
        self.feedbackLabel.layer.cornerRadius = 5
        self.feedbackLabel.clipsToBounds = true
        self.optAButton.layer.cornerRadius = 5
        self.optBButton.layer.cornerRadius = 5
        self.refreshButton.layer.cornerRadius = 5
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func refreshUI() {

        qManager.requestQuestion { (prompt, options, error) -> () in
            if error? == nil {
                self.questionTxtLabel.text = prompt
                self.optAButton.setTitle(options[0], forState: UIControlState.Normal)
                self.optBButton.setTitle(options[1], forState: UIControlState.Normal)
                self.feedbackLabel.text = ""
                self.feedbackLabel.hidden = true
                self.optAButton.hidden = false
                self.optBButton.hidden = false
                
                // Set a random banner img
                var randomIndex = Int(arc4random_uniform(UInt32(self.banner_imgs.count)))
                self.bannerImg.image = self.banner_imgs[randomIndex]
                
            } else {
                print("ERRRRRRR")
                print(error)
            }
        }
        
        //var qText: String
        //var qOpts: [String]
        //var qAnswerIndex: Int
        //(qText, qOpts) = qManager.getNewQuestion()
        
        //questionTxtLabel.text = qText
        //optAButton.setTitle(qOpts[0], forState: UIControlState.Normal)
        //optBButton.setTitle(qOpts[1], forState: UIControlState.Normal)
        //feedbackLabel.text = ""
        
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
    
    
    func evaluateResponse(chosenOptionIndex: Int) {
        // Set a random banner img
        var randomIndex = Int(arc4random_uniform(UInt32(self.banner_imgs.count)))
        self.bannerImg.image = self.banner_imgs[randomIndex]

        feedbackLabel.text = qManager.getFeedbackText(chosenOptionIndex)
        self.feedbackLabel.hidden = false
        self.optAButton.hidden = true
        self.optBButton.hidden = true
    }
    
    
}



class RDLabel: UILabel {
    
    override func drawTextInRect(rect: CGRect) {
        //let newRect = CGRectOffset(rect, 10, 0) // move text 10 points to the right
        //super.drawTextInRect(newRect)
        var insets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
}



