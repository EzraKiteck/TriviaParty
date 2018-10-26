//
//  Question.swift
//  TriviaParty
//
//  Created by Ezra Kiteck on 10/19/18.
//  Copyright © 2018 Ezra Kiteck. All rights reserved.
//

import Foundation

//A new class to handle all the different variables a question holds
class Question {
    
    //Properties
    let title: String
    let answers: [String]
    let correctAnswerIndex: Int
    var correctAnswer: String {
        return answers[correctAnswerIndex]
    }
    
    //Initializer
    init(title: String, answers: [String], correctAnswerIndex: Int) {
        self.title = title
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
    }
    
}

//Since the answer can only have four outcomes, it gets to be an enum
enum Answer {
    case A
    case B
    case C
    case D
}

