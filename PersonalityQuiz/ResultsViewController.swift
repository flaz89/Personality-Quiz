//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Flavio Mammoliti on 11/12/23.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet var resultAnswerLabel: UILabel!
    @IBOutlet var resultDefinitionLAbel: UILabel!
    @IBOutlet var resultImageView: UIImageView!
    
    var responses: [Answer]
    
    init?(coder: NSCoder, responses: [Answer]) {
        self.responses = responses
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculatePersonalityResults()
        let colorAttribute = [NSAttributedString.Key.foregroundColor: UIColor.white]
    
        navigationController?.navigationBar.titleTextAttributes = colorAttribute
        
    }
    
    // metodo che permette di trasformare l'array di Answer in dictionary, calcolare e comparar ele risposte per poi sortarle e identificare quella più utilizzata che rispecchia la personalità
    func calculatePersonalityResults() {
        let frequencyOfAnswer = responses.reduce(into: [:]) { (counts, answer) in
            counts[answer.type, default: 0] += 1
        }
        print(frequencyOfAnswer)
//        let frequentAnswerSorted = frequencyOfAnswer.sorted(by: { pair1, pair2 in
//            return pair1.value > pair2.value
//        })
        let mostCommonAnswer = frequencyOfAnswer.sorted { $0.1 > $1.1 } .first!.key
        changeImage(prod: mostCommonAnswer)
        resultAnswerLabel.text = "You are like \(mostCommonAnswer) \(mostCommonAnswer.rawValue)"
        resultDefinitionLAbel.text = mostCommonAnswer.definition
    }
    
    func changeImage(prod: AppleProd) {
        switch prod {
        case .iMac:
            resultImageView.image = UIImage(named: "imac")
        case .iphone:
            resultImageView.image = UIImage(named: "iphone")
        case .macBook:
            resultImageView.image = UIImage(named: "macbook")
        case .tvOs:
            resultImageView.image = UIImage(named: "iostv")
        case .watchOs:
            resultImageView.image = UIImage(named: "iwatch")
        }
    }

}
