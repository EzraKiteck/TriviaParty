//
//  ViewController.swift
//  TriviaParty
//
//  Created by Ezra Kiteck on 10/18/18.
//  Copyright © 2018 Ezra Kiteck. All rights reserved.
//

import UIKit

class TriviaGameViewController: UIViewController {
    
    //Variables
    var questions = [Question]()
    var historyQuestions = [Question]()
    var scienceQuestions = [Question]()
    var videoGameQuestions = [Question]()
    var questionsPlaceholder = [Question]()
    var currentIndex: Int!
    var category = UserDefaults.standard.integer(forKey: "category")
    
    //Preset Questions
    var hquestion1 = Question(title: "When was the world created?", answers: ["About 10,000 BC", "Billions of years ago", "1776", "The Year 0"], correctAnswerIndex: 0)
    var hquestion2 = Question(title: "Who was the first president of the USA?", answers: ["Abraham Lincoln", "George Garfield", "George Washington", "John Adams"], correctAnswerIndex: 2)
    var hquestion3 = Question(title: "Which lake was created by the construction of the Hoover Dam?", answers: ["Lake Hoover", "Lake Michigan", "The Great Salt Lake", "Lake Mead"], correctAnswerIndex: 3)
    var squestion1 = Question(title: "What is the second closest star to the Earth?", answers: ["The Sun", "Proxima Centauri", "Andromeda", "Polaris"], correctAnswerIndex: 1)
    var squestion2 = Question(title: "How do plants feed themselves?", answers: ["Photosynthesis", "Chlorophyl", "Stomata", "Oseoporosis"], correctAnswerIndex: 0)
    var squestion3 = Question(title: "Which is not a state of matter?", answers: ["Liquid", "Gas", "Energy", "Solid"], correctAnswerIndex: 3)
    var vquestion1 = Question(title: "What is the best-selling game of all time?", answers: ["Minecraft", "Tetris", "Super Mario Bros.", "Fortnite"], correctAnswerIndex: 1)
    var vquestion2 = Question(title: "What company saved video games from the video game crash of 1983?", answers: ["Sega", "Nintendo", "Ubisoft", "Bethesda"], correctAnswerIndex: 1)
    var vquestion3 = Question(title: "Who is the creator of Minecraft?", answers: ["John Williams", "Masahiro Sakari", "Markus 'Notch' Persson", "Bob"], correctAnswerIndex: 2)
    
    //Score
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    //Current question
    var currentQuestion: Question! {
        didSet {
            if let currentQuestion = currentQuestion {
                titleLabel.text = currentQuestion.title
                buttonA.setTitle(currentQuestion.answers[0], for: .normal)
                buttonB.setTitle(currentQuestion.answers[1], for: .normal)
                buttonC.setTitle(currentQuestion.answers[2], for: .normal)
                buttonD.setTitle(currentQuestion.answers[3], for: .normal)
                SetNewColors()
            }
        }
    }

    //UI Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        category = UserDefaults.standard.integer(forKey: "category")
        print(category)
        
        //Makes stuff easier
        let defaults = UserDefaults.standard
        
        //Gets value from the default "dictionary"
        let wins = defaults.integer(forKey: "wins")
        
        //Changes the value in the dictionary for a certain key
        defaults.set(wins + 1, forKey: "wins")
        
        */
        
        //Get first question
        PopulateQuestions()
        getNewQuestion()
        SetNewColors()
    }
    
    //Fills the question Array with the preset questions
    func PopulateQuestions() {
        questions = [hquestion1, hquestion2, hquestion3, squestion1, squestion2, squestion3, vquestion1, vquestion2, vquestion3]
        historyQuestions = [hquestion1, hquestion2, hquestion3]
        scienceQuestions = [squestion1, squestion2, squestion3]
        videoGameQuestions = [vquestion1, vquestion2, vquestion3]
    }
    
    //Shows a new question
    func getNewQuestion() {
        //If all questions have not been answered...
        if category == 0 {
            if historyQuestions.count > 0 {
                    currentIndex = Int.random(in: 0..<historyQuestions.count)
                    currentQuestion = historyQuestions[currentIndex]
            } else {
                //Otherwise, end the game.
                GameOverAlert()
            }
        }
        if category == 1 {
            if scienceQuestions.count > 0 {
                currentIndex = Int.random(in: 0..<scienceQuestions.count)
                currentQuestion = scienceQuestions[currentIndex]
            } else {
                //Otherwise, end the game.
                GameOverAlert()
            }
        }
        if category == 2 {
            if videoGameQuestions.count > 0 {
                currentIndex = Int.random(in: 0..<videoGameQuestions.count)
                currentQuestion = videoGameQuestions[currentIndex]
            } else {
                //Otherwise, end the game.
                GameOverAlert()
            }
        }
        if category == 3 {
            if questions.count > 0 {
                currentIndex = Int.random(in: 0..<questions.count)
                currentQuestion = questions[currentIndex]
            } else {
                //Otherwise, end the game.
                GameOverAlert()
            }
        }
    }
    
    //When answer is tapped...
    @IBAction func answerTapped(_ sender: UIButton) {
        //..determine if the question is right or not
        if (sender.tag == currentQuestion.correctAnswerIndex) {
            ShowCorrectAnswerAlert()
            score += 1
        } else {
            ShowIncorrectAnswerAlert(answer: sender.tag)
        }
    }
    
    //Gives alert to show answer is correct
    func ShowCorrectAnswerAlert() {
        let correctAlert = UIAlertController(title: "Correct", message: "\(currentQuestion.correctAnswer) is the correct answer!", preferredStyle: .actionSheet)
        let okayAction = UIAlertAction(title: "Thank you!", style: UIAlertAction.Style.default) { UIAlertAction in
            if self.category == 0 { self.questionsPlaceholder.append(self.historyQuestions[self.currentIndex])
                self.historyQuestions.remove(at: self.currentIndex)
            }
            if self.category == 1 { self.questionsPlaceholder.append(self.scienceQuestions[self.currentIndex])
                self.scienceQuestions.remove(at: self.currentIndex)
            }
            if self.category == 2 { self.questionsPlaceholder.append(self.videoGameQuestions[self.currentIndex])
                self.videoGameQuestions.remove(at: self.currentIndex)
            }
            if self.category == 3 { self.questionsPlaceholder.append(self.questions[self.currentIndex])
                self.questions.remove(at: self.currentIndex)
            }
            self.getNewQuestion()
            
        }
        correctAlert.addAction(okayAction)
        self.present(correctAlert, animated: true, completion: nil)
    }
    
    //Gives alert to show answer is incorrect
    func ShowIncorrectAnswerAlert(answer: Int) {
        let incorrectAlert = UIAlertController(title: "Incorrect", message: "\(currentQuestion.answers[answer]) is incorrect.", preferredStyle: .actionSheet)
        let okayAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { UIAlertAction in
            if self.category == 0 {
                self.questionsPlaceholder.append(self.historyQuestions[self.currentIndex])
                self.historyQuestions.remove(at: self.currentIndex)
            }
            if self.category == 1 {
                self.questionsPlaceholder.append(self.scienceQuestions[self.currentIndex])
                self.scienceQuestions.remove(at: self.currentIndex)
            }
            if self.category == 2 {
                self.questionsPlaceholder.append(self.videoGameQuestions[self.currentIndex])
                self.videoGameQuestions.remove(at: self.currentIndex)
            }
            if self.category == 3 {
                self.questionsPlaceholder.append(self.questions[self.currentIndex])
                self.questions.remove(at: self.currentIndex)
            }
            self.getNewQuestion()
        }
        incorrectAlert.addAction(okayAction)
        self.present(incorrectAlert, animated: true, completion: nil)
    }
    
    //Tells the user their score, then resets the game
    func GameOverAlert() {
        let endAlert = UIAlertController(title: "Trivia Results", message: "Game Over! Your score was \(score) out of \(questionsPlaceholder.count)", preferredStyle: UIAlertController.Style.alert)
        let resetAction = UIAlertAction(title: "Reset", style: UIAlertAction.Style.default) {UIAlertAction in
            self.resetGame()
        }
        endAlert.addAction(resetAction)
        self.present(endAlert, animated: true, completion: nil)
    }
    
    //Reset Button
    @IBAction func resetButtonPressed(_ sender: Any) {
        resetGame()
    }
    
    //Reset the game
    func resetGame() {
        //Set score to 0
        score = 0
        
        //If there are questions in the placeholder, then use those questions to reset the original questions array
        if !questionsPlaceholder.isEmpty {
            if category == 0 {
                questionsPlaceholder.append(contentsOf: historyQuestions)
                historyQuestions.removeAll()
                historyQuestions = questionsPlaceholder
                questionsPlaceholder.removeAll()
            }
            if category == 1 {
                questionsPlaceholder.append(contentsOf: scienceQuestions)
                scienceQuestions.removeAll()
                scienceQuestions = questionsPlaceholder
                questionsPlaceholder.removeAll()
            }
            if category == 2 {
                questionsPlaceholder.append(contentsOf: videoGameQuestions)
                videoGameQuestions.removeAll()
                videoGameQuestions = questionsPlaceholder
                questionsPlaceholder.removeAll()
            }
            if category == 3 {
                questionsPlaceholder.append(contentsOf: questions)
                questions.removeAll()
                questions = questionsPlaceholder
                questionsPlaceholder.removeAll()
            }
        }
        //Get a new question
        getNewQuestion()
        
    }
    
    //Resets when back is pressed
    @IBAction func backButtonPressed(_ sender: Any) {
        resetGame()
    }
    
    
    //Array of possible button colors
    let backgroundColors = [UIColor(red:0.84, green:0.00, blue:0.00, alpha:1.0), UIColor(red:0.00, green:0.44, blue:1.00, alpha:1.0), UIColor(red:0.92, green:0.46, blue:0.00, alpha:1.0), UIColor(red:0.00, green:0.56, blue:0.00, alpha:1.0)]
    
    //Gives a random color to each button
    func SetNewColors() {
        let randomNumber = Int.random(in: 1...100)
        let randomColorA = backgroundColors[randomNumber % 4]
        let randomColorB = backgroundColors[(randomNumber + 1) % 4]
        let randomColorC = backgroundColors[(randomNumber + 2) % 4]
        let randomColorD = backgroundColors[(randomNumber + 3) % 4]
        
        buttonA.backgroundColor = randomColorA
        buttonB.backgroundColor = randomColorB
        buttonC.backgroundColor = randomColorC
        buttonD.backgroundColor = randomColorD
    }
    
    //Smoothens the corners of any object
    func applyRoundCorner(_ object: AnyObject) {
        object.layer?.cornerRadius = object.frame.size.width / 32
        object.layer?.masksToBounds = true
    }
    
    @IBAction func unwindToTriviaScreen(segue: UIStoryboardSegue){}

}
