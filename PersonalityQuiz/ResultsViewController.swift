//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Thompson, Justin D on 1/30/20.
//  Copyright © 2020 Thompson, Justin D. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var responses: [Answer]!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var definitionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculatePersonalityResult()
    }
    
    func calculatePersonalityResult(){
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        let responseTypes = responses.map {$0.type}
        for response in responseTypes {
            if let count = frequencyOfAnswers[response] {
                frequencyOfAnswers[response] = count + 1
            }
            else{
                frequencyOfAnswers[response] = 1
            }
        }
        let frequentAnswersSorted = frequencyOfAnswers.sorted(by: {(pair1, pair2) -> Bool in return pair1.value > pair2.value})
        let mostCommonAnswer = frequentAnswersSorted.first!.key
        
        answerLabel.text = "You are a \(mostCommonAnswer)"
        definitionLabel.text = mostCommonAnswer.definition
        
    }

    

}
