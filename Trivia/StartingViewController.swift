//
//  ViewController.swift
//  Trivia
//
//  Created by Sterre Smit on 09/12/2018.
//  Copyright © 2018 Sterre Smit. All rights reserved.
//

import UIKit

class StartingViewController: UIViewController {
    
    var highScoreStorage: HighScore!

    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var userNameField: UITextField!
    

    @IBAction func editedUsernameField(_ sender: UITextField) {
        updateStartButton()
    }
    
    
    func updateStartButton() {
        let text = userNameField.text ?? ""
        startGameButton.isEnabled = !text.isEmpty

    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        
    }
    
    
    override func viewDidLoad() {
        updateStartButton()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func unwindToStartScreen(segue: UIStoryboardSegue){
        if segue.identifier == "DismissGame" {
            userNameField.text = ""
        
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "GameStartingSegue" {
        let navViewController = segue.destination as! UINavigationController
        let questionViewController = navViewController.topViewController as! QuestionViewController
        highScoreStorage = HighScore(name: userNameField.text!, score: "0")
        questionViewController.highScore = highScoreStorage
            
            
          }
}
}
