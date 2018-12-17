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
    
    // making the status bar white to match appearrance
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
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
        // Fetching question data from the API
        QuestionController.shared.fetchQuestions { (questionItems) in
            if let questionItems = questionItems {
                DispatchQueue.main.async {
                    self.updateUI(with: questionItems)
                }
            }
        }
    }
    
    //        if right answer pressed do something and +1 score, edit score label, move on to next
    @IBAction func answerGiven (_ sender: UIButton) {
        if sender.currentTitle == currentQuestion.correctAnswer  {
            correctAnswersScore += 1
            scoreCountLabel.text = "Score: \(correctAnswersScore)"
            
            nextQuestion()
            //      if wrong, no points are rewarded, then move on
        } else {
            correctAnswersScore += 0
            nextQuestion()
        }
    }
    
    // Initial question loaded with the question item file
    func updateUI(with questionItems: [QuestionItem]) {
        questions = questionItems
        nextQuestion()
    }
    
    // Displaying the answers
    func fillInAnswers(using answers: [String]) {
        answerButtonOne.setTitle(answers[0].removingHTMLEntities, for: .normal)
        answerButtonTwo.setTitle(answers[1].removingHTMLEntities, for: .normal)
        answerButtonThree.setTitle(answers[2].removingHTMLEntities, for: .normal)
        answerButtonFour.setTitle(answers[3].removingHTMLEntities, for: .normal)
    }
    
    // When the question is answered, move to next one as long as there is one more left
    func nextQuestion() {
        questionIndex += 1
        if questionIndex < questions.count {
            currentQuestion = questions[questionIndex]
            questionLabel.text = currentQuestion.question.removingHTMLEntities
            fillInAnswers(using: currentQuestion.answerList)
            questionsRemainingLabel.text = "\(questions.count - questionIndex) more to go! "
            
        } else {
            // Whenever no more questions are available, create score and move to High Score screen
            scoreCreation()
            performSegue(withIdentifier: "ScoreViewSegue", sender: nil)
            
            
        }
    }
    // Function creating the score according to the high score model
    func scoreCreation() {
        QuestionController.shared.addHighScore(highScore: highScore) { () in
            DispatchQueue.main.async {
            }
        }
    }
    // Passing the score and username to the next TableviewController,
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ScoreViewSegue" {
            let scoreTableViewController = segue.destination as! ScoreTableViewController
            //converting the score into a string so it can be displayed as detail in the tableview
            //highScore.score = String(correctAnswersScore)
            // appending the score to the highscore list on the server
            //scoreTableViewController.highScores.append(highScore)
            
        }
        
    }
    
}
