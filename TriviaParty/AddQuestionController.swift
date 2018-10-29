//
//  AddQuestion.swift
//  TriviaParty
//
//  Created by Ezra Kiteck on 10/19/18.
//  Copyright © 2018 Ezra Kiteck. All rights reserved.
//

import UIKit

class AddQuestionController: UIViewController {
    
    //Variables
    var newQuestion: Question?
    var Category = "Everything"
    
    //UI Elements
    @IBOutlet weak var newQuestionTextField: UITextField!
    @IBOutlet weak var answerATextField: UITextField!
    @IBOutlet weak var answerBTextField: UITextField!
    @IBOutlet weak var answerCTextField: UITextField!
    @IBOutlet weak var answerDTextField: UITextField!
    @IBOutlet weak var correctAnswerSelection: UISegmentedControl!
    @IBOutlet weak var categorySelection: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
    }
    
    //Reverts to the Trivia screen
    @IBAction func returnToTriviaScreen(_ sender: Any) {
        performSegue(withIdentifier: "unwindToTriviaScreen", sender: self)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        //If any fields are empty...
        guard
            let question = newQuestionTextField.text, !question.isEmpty,
            let a = answerATextField.text, !a.isEmpty,
            let b = answerBTextField.text, !b.isEmpty,
            let c = answerCTextField.text, !c.isEmpty,
            let d = answerDTextField.text, !d.isEmpty
        else {
            //...send an alert to the user.
            let errorAlert = UIAlertController(title: "Error", message: "Please fill all text fields", preferredStyle: UIAlertController.Style.alert)
            let dismissAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {UIAlertAction in}
            errorAlert.addAction(dismissAction)
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        //Else, if all fields are filled, then create a new question and go back to the Trivia screen
        newQuestion = Question(title: question, answers: [a, b, c, d], correctAnswerIndex: correctAnswerSelection.selectedSegmentIndex)
        performSegue(withIdentifier: "unwindToTriviaScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destinationVC = segue.destination as? TriviaGameViewController,
            let newTriviaQuestion = newQuestion
            else {return}
        destinationVC.questions.append(newTriviaQuestion)
        if categorySelection.selectedSegmentIndex == 0 {
            destinationVC.historyQuestions.append(newTriviaQuestion)
        }
        if categorySelection.selectedSegmentIndex == 1 {
            destinationVC.scienceQuestions.append(newTriviaQuestion)
        }
        if categorySelection.selectedSegmentIndex == 2 {
            destinationVC.videoGameQuestions.append(newTriviaQuestion)
        }
        destinationVC.resetGame()
    }
    
}
