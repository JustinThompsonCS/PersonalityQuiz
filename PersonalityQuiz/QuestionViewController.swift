//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Thompson, Justin D on 1/30/20.
//  Copyright © 2020 Thompson, Justin D. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    var questions: [Question] = [
        Question(text: "Which food do you like the most?",
                 type: .single,
                 answers: [
                    Answer(text: "Steak", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Carrots", type: .rabbit),
                    Answer(text: "Corn", type: .turtle)
                          ]),
        Question(text: "Which activities to you enjoy?",
                 type: .multiple,
                 answers: [
                    Answer(text: "Swimming", type: .turtle),
                    Answer(text: "Sleeping", type: .cat),
                    Answer(text: "Cuddling", type: .rabbit),
                    Answer(text: "Eating", type: .dog)
                 ]),
        Question(text: "How much do you enjoy car rides?",
                 type: .ranged,
                 answers: [
                    Answer(text: "I dislike them", type: .cat),
                    Answer(text: "I get a little nervous", type: .rabbit),
                    Answer(text: "I barely notice them", type: .turtle),
                    Answer(text: "I love them", type: .dog)
                 ])
    ]
    var questionIndex = 0
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButton1: UIButton!
    @IBOutlet var singleButton2: UIButton!
    @IBOutlet var singleButton3: UIButton!
    @IBOutlet var singleButton4: UIButton!
    
    
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multiLable1: UILabel!
    @IBOutlet var multiLabel2: UILabel!
    @IBOutlet var multiLabel3: UILabel!
    @IBOutlet var multiLabel4: UILabel!
    
    @IBOutlet var multiSwitch1: UISwitch!
    @IBOutlet var multiSwitch2: UISwitch!
    @IBOutlet var multiSwitch3: UISwitch!
    @IBOutlet var multiSwitch4: UISwitch!
    
    
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLabel1: UILabel!
    @IBOutlet var rangedLabel2: UILabel!
    
    @IBOutlet var rangedSlider: UISlider!
    
    
    
    @IBOutlet var questionProgressView: UIProgressView!
    
    
    @IBOutlet var questionTextLabel: UILabel!
    
    var answersChosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    
    
    func updateUI(){
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        questionTextLabel.text = currentQuestion.text
        
        switch currentQuestion.type{
        case .single:
            updateSingleStack(using: currentAnswers)
            singleStackView.isHidden = false
        case .multiple:
            updateMultipleStack(using: currentAnswers)
            multipleStackView.isHidden = false
        case .ranged:
            updateRangedStack(using: currentAnswers)
            rangedStackView.isHidden = false
        }
        questionProgressView.setProgress(totalProgress, animated: true)
    }
    
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        switch sender {
        case singleButton1:
            answersChosen.append(questions[questionIndex].answers[0])
        case singleButton2:
            answersChosen.append(questions[questionIndex].answers[1])
        case singleButton3:
            answersChosen.append(questions[questionIndex].answers[2])
        case singleButton4:
            answersChosen.append(questions[questionIndex].answers[3])
        default:
            break
        }
        nextQuestion()
    }
    
    @IBAction func multiAnswerButtonPressed(_ sender: Any) {
        if(multiSwitch1.isOn == true){
            answersChosen.append(questions[questionIndex].answers[0])
        }
        if(multiSwitch2.isOn == true){
            answersChosen.append(questions[questionIndex].answers[1])
        }
        if(multiSwitch3.isOn == true){
            answersChosen.append(questions[questionIndex].answers[2])
        }
        if(multiSwitch4.isOn == true){
            answersChosen.append(questions[questionIndex].answers[3])
        }
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed(_ sender: Any) {
        let index = Int(round(rangedSlider.value * Float(questions[questionIndex].answers.count - 1)))
        answersChosen.append(questions[questionIndex].answers[index])
        nextQuestion()
    }
    
    func nextQuestion(){
        questionIndex = questionIndex + 1
        if(questionIndex < questions.count){
            updateUI()
        }
        else{
            
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
        
    }
    
    
    
    func updateSingleStack(using answers: [Answer]){
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    func updateMultipleStack(using answers: [Answer]){
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLable1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    func updateRangedStack(using answers: [Answer]){
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers[0].text
        rangedLabel2.text = answers[3].text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ResultsSegue"){
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }

}
