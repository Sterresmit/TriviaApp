//
//  QuestionController.swift
//  Trivia
//
//  Created by Sterre Smit on 10/12/2018.
//  Copyright © 2018 Sterre Smit. All rights reserved.
//

import Foundation
class QuestionController {
    
    // Definitions of used URL's
    let baseURL = URL(string: "https://opentdb.com/api.php?amount=10&type=multiple")!
    let hsListURL = URL(string: "https://ide50-sterrie.cs50.io:8080/highscorelist")!
    
    
    static let shared = QuestionController()
    
    // Fetch questions from open API, decoding them from JSON format
    func fetchQuestions(completion: @escaping ([QuestionItem]?) -> Void) {
        let task = URLSession.shared.dataTask(with: baseURL)
        {(data, response,error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let questionItems = try? jsonDecoder.decode(QuestionItems.self, from: data){
                completion(questionItems.results)
            } else {
                print("no questions found")
                completion(nil)
            }
        }
        task.resume()
        
    }
    // Add high score to personal server space with name and score
    func addHighScore(highScore: HighScore, completion: @escaping () -> Void ){
        let highScoreURL = URL(string: "https://ide50-sterrie.cs50.io:8080/highscorelist")!
        var request = URLRequest(url: highScoreURL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "user=\(highScore.name)&score=\(highScore.score)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            completion()
        }
        task.resume()
    }
    
    // Fetching the list of stored highscores with name
    func fetchHighScores(completion: @escaping ([HighScore]?)-> Void) {
        let task = URLSession.shared.dataTask(with: hsListURL)
        { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let highScoreIt = try? jsonDecoder.decode([HighScore].self, from: data) {
                completion(highScoreIt)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
}
