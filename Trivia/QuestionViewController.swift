//
//  QuestionViewController.swift
//  Trivia
//
//  Created by Sterre Smit on 10/12/2018.
//  Copyright © 2018 Sterre Smit. All rights reserved.
//

import UIKit
import HTMLString

class QuestionViewController: UIViewController {
    var playerName: String!
    
    
    
    var questionController = QuestionController()
    var questions = [QuestionItem]()
    
    
    var questionIndex = 0
    var correctAnswersScore = 0
    var currentQuestion: QuestionItem!
    var highScore: HighScore!
    
    
    // The question + answer outlets
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerButtonOne: UIButton!
    @IBOutlet weak var answerButtonTwo: UIButton!
    @IBOutlet weak var answerButtonThree: UIButton!
    @IBOutlet weak var answerButtonFour: UIButton!
    
    // Indicator outlets
    @IBOutlet weak var scoreCountLabel: UILabel!
    @IBOutlet weak var questionsRemainingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QuestionController.shared.fetchQuestions { (questionItems) in
            if let questionItems = questionItems {
                DispatchQueue.main.async {
                    self.updateUI(with: questionItems)
                }
            }
        }
    }
    
    
    @IBAction func answerGiven (_ sender: UIButton) {
        //        if right answer pressed do something and +1 score, edit score label, move on to next
        if sender.currentTitle == currentQuestion.correctAnswer  {
            correctAnswersScore += 1
            scoreCountLabel.text = "Score: \(correctAnswersScore)"
            
            nextQuestion()
            //      if wrong, light up right answer and wait a sec, then move on
        } else {
            correctAnswersScore += 0
            nextQuestion()
        }
    }
    
    
    func updateUI(with questionItems: [QuestionItem]) {
        questions = questionItems
        nextQuestion()
    }
    
    func fillInAnswers(using answers: [String]) {
        answerButtonOne.setTitle(answers[0].removingHTMLEntities, for: .normal)
        answerButtonTwo.setTitle(answers[1].removingHTMLEntities, for: .normal)
        answerButtonThree.setTitle(answers[2].removingHTMLEntities, for: .normal)
        answerButtonFour.setTitle(answers[3].removingHTMLEntities, for: .normal)
    }
    
    func nextQuestion() {
        questionIndex += 1
        if questionIndex < questions.count {
            currentQuestion = questions[questionIndex]
            questionLabel.text = currentQuestion.question.removingHTMLEntities
            fillInAnswers(using: currentQuestion.answerList)
            questionsRemainingLabel.text = "\(questions.count - questionIndex) more to go! "
            
        } else {
            scoreCreation()
            
            performSegue(withIdentifier: "ScoreViewSegue", sender: nil)
            
            
        }
    }
    
    func scoreCreation() {
        QuestionController.shared.addHighScore(highScore: highScore) { () in
             DispatchQueue.main.async {
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ScoreViewSegue" {
            let scoreTableViewController = segue.destination as! ScoreTableViewController
            highScore.score = String(correctAnswersScore)
            scoreTableViewController.highScores.append(highScore)

        }

}

}
