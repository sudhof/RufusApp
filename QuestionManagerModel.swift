//
//  QuestionManagerModel.swift
//  RufRuf
//
//  Created by Momo Sudplant on 2/2/15.
//  Copyright (c) 2015 Fatherstone Zenithpeak. All rights reserved.
//

import Foundation


class QuestionManagerModel {
    
    var currQuestion: String = ""
    var currOptions: [String] = []
    var currCorrectAnswerIndex: Int = 0
    
    init() {
        // Go ahead and fetch a question
        self.fetchQuestion()
    }

    func getNewQuestion() -> (String, [String], Int) {
        // Returns a tuple of question info:
        //      the text, answer options, and the index of the correct answer
        // First, fetch a new question
        self.fetchQuestion()
        return (currQuestion, currOptions, currCorrectAnswerIndex);
    }
    func getCachedQuestion() -> (String, [String], Int) {
        // Returns the current question
        return (currQuestion, currOptions, currCorrectAnswerIndex);
    }

    
    func getQuestionText() -> String {
        return currQuestion;
    }
    func getQuestionOptions() -> [String] {
        return currOptions;
    }
    func getCorrectAnswerText() -> String {
        return currOptions[currCorrectAnswerIndex];
    }
    func getCorrectAnswerIndex() -> Int {
        return currCorrectAnswerIndex;
    }
    func checkAnswerIsCorrect(chosenOptionIndex: Int) -> Bool {
        if chosenOptionIndex == currCorrectAnswerIndex {
            return true
        }
        return false
    }
    func getFeedbackText(chosenOptionIndex: Int) -> String {
        // To be replaced by question- (and maybe answer-)
        // specific text
        if checkAnswerIsCorrect(chosenOptionIndex) {
            return "That's right!!"
        } else {
            return "Nope, sorry, it's actually " + getCorrectAnswerText() + "."
        }
    }
    
    func fetchQuestion() {
        // "Fetching" from the same set of questions, over and over
        var questions = ["Which country has the greatest religious diversity?", "Which country boasts the most opera singers?", "Which country has the most hydropower installations?", "Which country is the coolest country in all the world?", "Which country consumes the most heavy cream?", "Which country is responsible for the greatest asphalt production?"]
        var randomIndex = Int(arc4random_uniform(UInt32(questions.count)))
        currQuestion = questions[randomIndex]
        currOptions = ["China", "US", "Sweden"]
        currCorrectAnswerIndex = 0
    }

    
}

/*

class TipCalculatorModel {
    
    var total: Double
    var taxPct: Double
    var subtotal: Double {
        get {
            return total / (taxPct + 1)
        }
    }
    
    init(total: Double, taxPct: Double) {
        self.total = total
        self.taxPct = taxPct
    }
    
    func calcTipWithTipPct(tipPct: Double) -> Double {
        return subtotal * tipPct
    }
    
    func returnPossibleTips() -> [Int: Double] {
        
        let possibleTipsInferred = [0.15, 0.18, 0.20]
        let possibleTipsExplicit:[Double] = [0.15, 0.18, 0.20]
        
        var retval = [Int: Double]()
        for possibleTip in possibleTipsInferred {
            let intPct = Int(possibleTip*100)
            retval[intPct] = calcTipWithTipPct(possibleTip)
        }
        return retval
        
    }
    
}

*/


