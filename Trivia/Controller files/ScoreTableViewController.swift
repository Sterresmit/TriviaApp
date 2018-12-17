//
//  ScoreViewController.swift
//  Trivia
//
//  Created by Sterre Smit on 10/12/2018.
//  Copyright © 2018 Sterre Smit. All rights reserved.
//

import UIKit

class ScoreTableViewController: UITableViewController {
    
    
    var highScores =  [HighScore]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllHighScores()
        navigationItem.hidesBackButton = true
    }
    
    // number of rows set to number of high scores stored
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return highScores.count
    }
    // calling configure to fill in rows table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreID", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    // setting text to name and score
    func configure(_ cell: UITableViewCell, forItemAt indexPath:
        IndexPath) {
        cell.textLabel?.text = highScores[indexPath.row].name
        cell.detailTextLabel?.text = highScores[indexPath.row].score
        
    }
    // calling function to fetch high score list from server
    func getAllHighScores() {
        QuestionController.shared.fetchHighScores { (highScore) in
            if let highScoresList = highScore { DispatchQueue.main.async {
                self.highScores = highScoresList
                self.tableView.reloadData()
                }
                
            }
            
        }
    }
    
}


