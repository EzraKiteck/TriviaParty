//
//  ViewController.swift
//  TriviaParty
//
//  Created by Ezra Kiteck on 10/18/18.
//  Copyright © 2018 Ezra Kiteck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    let firstQuestion = Question(title: "How am I feeling?", answerA: "Joyous", answerB: "Depressed", answerC: "Inquisitive", answerD: "All of the above", correctAnswer: .A)

    //UI Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Show firstQuestion
        ShowQuestion(question: firstQuestion)
    }
    
    func ShowQuestion(question: Question) {
        //Set title to questionTitle
        titleLabel.text = question.title
        //List answers
        buttonA.setTitle(question.answerA, for: .normal)
        buttonB.setTitle(question.answerB, for: .normal)
        buttonC.setTitle(question.answerC, for: .normal)
        buttonD.setTitle(question.answerD, for: .normal)
    }


}

//A new class to handle all the different variables a question holds
class Question {
    
    //Properties
    let title: String
    let answerA: String
    let answerB: String
    let answerC: String
    let answerD: String
    let correctAnswer: Answer
    
    //Initializer
    init(title: String, answerA: String, answerB: String, answerC: String, answerD: String, correctAnswer: Answer) {
        self.title = title
        self.answerA = answerA
        self.answerB = answerB
        self.answerC = answerC
        self.answerD = answerD
        self.correctAnswer = correctAnswer
    }
    
}

//Since the answer can only have four outcomes, it gets to be an enum
enum Answer {
    case A
    case B
    case C
    case D
}
