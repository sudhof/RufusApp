//
//  QuestionManagerModel.swift
//  RufRuf
//
//  Created by Momo Sudplant on 2/2/15.
//  Copyright (c) 2015 Fatherstone Zenithpeak. All rights reserved.
//

import Foundation

public typealias QuestionRequestCompletionBlock = (prompt: String?, options: [String], error: NSError?) -> ()

class QuestionManagerModel {
    
    // For API
    let defaults = NSUserDefaults.standardUserDefaults()
    let session: NSURLSession
    let URL = "https://ohrufus.herokuapp.com/get-question"
    

    init() {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: configuration);
    }

    func getNewQuestion() -> (String, [String]) {
        // Returns a tuple of question info:
        //      the text, answer options
        // First, fetch a new question
        return (getQuestionText(), getQuestionOptions());
    }
    func getCachedQuestion() -> (String, [String]) {
        // Returns the current question
        return (getQuestionText(), getQuestionOptions());
    }

    func getQuestionText() -> String {
        if let prompt = defaults.objectForKey("prompt") as? String {
            return prompt
        }
        return "Error fetching question"
    }
    
    func getQuestionOptions() -> [String] {
        if let options = defaults.objectForKey("qoptions") as? [String] {
            return options
        }
        return ["Error", "Error"]
    }
    func getCorrectAnswerIndex() -> Int {
        if let index = defaults.objectForKey("target") as? Int {
            return index
        }
        return 0
    }
    func checkAnswerIsCorrect(chosenOptionIndex: Int) -> Bool {
        if chosenOptionIndex == getCorrectAnswerIndex() {
            return true
        }
        return false
    }
    func getFeedbackText(chosenOptionIndex: Int) -> String {
        var feedback: String = ""
        if let response = defaults.objectForKey("response") as? String {
            feedback = response
        }
        if checkAnswerIsCorrect(chosenOptionIndex) {
            return "That's right!! " + feedback;
        } else {
            return "Nope, sorry. " + feedback;
        }
    }
    

    public func requestQuestion(completion: QuestionRequestCompletionBlock) {
        let request = NSURLRequest(URL: NSURL(string: URL)!)
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                var JSONError: NSError?
                let responseDict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &JSONError) as NSDictionary
                if JSONError == nil {
                    let prompt: String = responseDict["prompt"] as String
                    let correctIndex: Int = responseDict["target"] as Int
                    let response: String = responseDict["response"] as String
                    let options: [String] = responseDict["options"] as [String]
                    self.defaults.setObject(prompt, forKey: "prompt")
                    self.defaults.setObject(correctIndex, forKey: "correctIndex")
                    self.defaults.setObject(response, forKey: "response")
                    self.defaults.setObject(options, forKey: "qoptions")
                    self.defaults.synchronize()
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completion(prompt: prompt, options: options, error: nil)
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completion(prompt: nil, options: ["err", "err"], error: JSONError)
                    })
                }
            } else {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    completion(prompt: nil, options: ["err", "err"], error: error)
                })
            }
        })
        task.resume()
    }
    
}



