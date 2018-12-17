//
//  QuestionData.swift
//  Trivia
//
//  Created by Sterre Smit on 10/12/2018.
//  Copyright © 2018 Sterre Smit. All rights reserved.
//

import UIKit
struct QuestionItem: Codable {
    var type: String
    var difficulty: String
    var question: String
    var correctAnswer: String
    var incorrectAnswer: [String]
    // antwoorden hus
    var answerList: [String] {
        var answerList = incorrectAnswer
        answerList.append(correctAnswer)
        return answerList.shuffled()
    }
    
        enum CodingKeys: String, CodingKey {
            case type
            case difficulty
            case question
            case correctAnswer = "correct_answer"
            case incorrectAnswer = "incorrect_answers"
    }
}

struct QuestionItems: Codable {
    let results: [QuestionItem]
    }


