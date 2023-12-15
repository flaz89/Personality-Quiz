//
//  QuestionsViewController.swift
//  PersonalityQuiz
//
//  Created by Flavio Mammoliti on 11/12/23.
//

import UIKit

class QuestionViewController: UIViewController {
    // UI condivisa
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var questionsProgress: UIProgressView!
    
    // UI domanda risposta singola
    @IBOutlet var singleAnswerView: UIStackView!
    @IBOutlet var singleBtn1: UIButton!
    @IBOutlet var singleBtn2: UIButton!
    @IBOutlet var singleBtn3: UIButton!
    @IBOutlet var singleBtn4: UIButton!
    @IBOutlet var singleBtn5: UIButton!
    
    // UI risposta multipla
    @IBOutlet var multipleAnswerView: UIStackView!
    @IBOutlet var multiLabel1: UILabel!
    @IBOutlet var multiLabel2: UILabel!
    @IBOutlet var multiLabel3: UILabel!
    @IBOutlet var multiLabel4: UILabel!
    @IBOutlet var multiLabel5: UILabel!
    @IBOutlet var switch1: UISwitch!
    @IBOutlet var switch2: UISwitch!
    @IBOutlet var switch3: UISwitch!
    @IBOutlet var switch4: UISwitch!
    @IBOutlet var switch5: UISwitch!
    
    // UI slider
    @IBOutlet var rangedView: UIStackView!
    @IBOutlet var rangedSlider: UISlider!
    @IBOutlet var rangedLabel1: UILabel!
    @IBOutlet var rangedLabel2: UILabel!
    @IBOutlet var rangedLabel3: UILabel!
    @IBOutlet var rangedLabel4: UILabel!
    @IBOutlet var rangedLabel5: UILabel!
    
    let questions: [Question] = [
        Question(text: "Do you like practice sports?", type: .ranged, answer: [
            Answer(text: "1", type: .tvOs),
            Answer(text: "2", type: .iMac),
            Answer(text: "3", type: .macBook),
            Answer(text: "4", type: .iphone),
            Answer(text: "5", type: .watchOs)
        ]),
        Question(text: "What's your best spot to watch movies?", type: .single, answer: [
            Answer(text: "Sofa", type: .tvOs),
            Answer(text: "At Work", type: .iMac),
            Answer(text: "Bed", type: .macBook),
            Answer(text: "Bus", type: .iphone),
            Answer(text: "Cinema", type: .watchOs)
        ]),
        Question(text: "Where do you like to work?", type: .single, answer: [
            Answer(text: "No work please", type: .tvOs),
            Answer(text: "At Work", type: .iMac),
            Answer(text: "Beach", type: .macBook),
            Answer(text: "Subway", type: .iphone),
            Answer(text: "Holiday", type: .watchOs)
        ]),
        Question(text: "Which activities do you enjoy most?", type: .multiple, answer: [
            Answer(text: "Sleeping", type: .tvOs),
            Answer(text: "Eating", type: .iMac),
            Answer(text: "Snowboarding", type: .macBook),
            Answer(text: "Playing card", type: .iphone),
            Answer(text: "Swimming", type: .watchOs)
        ]),
        Question(text: "Do you prefer salty or sweet food?", type: .ranged, answer: [
            Answer(text: "1", type: .tvOs),
            Answer(text: "2", type: .iMac),
            Answer(text: "3", type: .macBook),
            Answer(text: "4", type: .iphone),
            Answer(text: "5", type: .watchOs)
        ])
    ]
    
    // array che contiene le risposte selezionate
    var answerChosen: [Answer] = []
    var questionIndex: Int = 0
    var answerIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // metodo che aggiorna gli elementi dell'UI
    func updateUI() {
        singleAnswerView.isHidden = true
        multipleAnswerView.isHidden = true
        rangedView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answer
        let totalProgress = Float(questionIndex) / Float(questions.count - 1)
        
        navigationItem.title = "Question n° \(questionIndex + 1)"
        questionLabel.text = currentQuestion.text
        questionsProgress.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .multiple:
            updateMultipleView(with: currentAnswers)
        case .single:
            updateSingleBtnView(with: currentAnswers)
        case .ranged:
            updateRangedView(with: currentAnswers)
        }
    }
    
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, responses: answerChosen)
    }
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "Results", sender: nil)
        }
    }
    
    // metodo che registra la risposta ricevuta nella modalita risposta singola
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answer
        
        switch sender {
        case singleBtn1:
            answerChosen.append(currentAnswers[0])
        case singleBtn2:
            answerChosen.append(currentAnswers[1])
        case singleBtn3:
            answerChosen.append(currentAnswers[2])
        case singleBtn4:
            answerChosen.append(currentAnswers[3])
        case singleBtn5:
            answerChosen.append(currentAnswers[4])
        default:
            break
        }
        
        nextQuestion()
    }
    
    // metodo che registra la risposta ricevuta nella modalita risposta multipla
    @IBAction func multipleAnswerButtonPressed() {
        var currentAnswers = questions[questionIndex].answer
        let answersSwitches = [switch1, switch2, switch3, switch4, switch5]
        
        for (index, element) in answersSwitches.enumerated() {
            if ((element?.isOn) != nil) {
                currentAnswers.append(currentAnswers[index])
            }
        }
        nextQuestion()
    }
    
    // metodo che registra la risposta ricevuta nella modalita risposta ranged
    @IBAction func sliderAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answer
        
        answerChosen.append(currentAnswers[answerIndex])
        
        nextQuestion()
        print(answerIndex)
        
    }
    
    // metodo che imposta il valore dello slider su un range specifico
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let value = sender.value
        
        if value < 0.125 {
            sender.value = 0.0
            answerIndex = 0
        } else if value >= 0.125 && value < 0.375 {
            sender.value = 0.25
            answerIndex = 1
        } else if value >= 0.375 && value < 0.625 {
            sender.value = 0.5
            answerIndex = 2
        } else if value >= 0.625 && value < 0.875 {
            sender.value = 0.75
            answerIndex = 3
        } else {
            sender.value = 1.0
            answerIndex = 4
        }
    }
    
    func updateSingleBtnView(with answer:[Answer]) {
        singleAnswerView.isHidden = false
        singleBtn1.setTitle(answer[0].text, for: .normal)
        singleBtn2.setTitle(answer[1].text, for: .normal)
        singleBtn3.setTitle(answer[2].text, for: .normal)
        singleBtn4.setTitle(answer[3].text, for: .normal)
        singleBtn5.setTitle(answer[4].text, for: .normal)
    }
    
    func updateMultipleView(with answer:[Answer]) {
        multipleAnswerView.isHidden = false
        switch1.isOn = false
        switch2.isOn = false
        switch3.isOn = false
        switch4.isOn = false
        switch5.isOn = false
        multiLabel1.text = answer[0].text
        multiLabel2.text = answer[1].text
        multiLabel3.text = answer[2].text
        multiLabel4.text = answer[3].text
        multiLabel5.text = answer[4].text
    }
    
    func updateRangedView(with answer:[Answer]) {
        rangedView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answer[0].text
        rangedLabel2.text = answer[1].text
        rangedLabel3.text = answer[2].text
        rangedLabel4.text = answer[3].text
        rangedLabel5.text = answer[4].text
    }
    

}
