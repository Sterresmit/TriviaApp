//
//  ViewController.swift
//  Trivia
//
//  Created by Sterre Smit on 09/12/2018.
//  Copyright © 2018 Sterre Smit. All rights reserved.
//

import UIKit

class StartingViewController: UIViewController {
    // making the status bar white to match appearrance 
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var highScoreStorage: HighScore!
    
    // Button & Username outlets
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var userNameField: UITextField!
    
    // Whenever text is edited in the textfield, function to update the start button is called
    @IBAction func editedUsernameField(_ sender: UITextField) {
        updateStartButton()
    }
    
    // The start game button is disabled whenever the user does not fill in a name
    func updateStartButton() {
        let text = userNameField.text ?? ""
        startGameButton.isEnabled = !text.isEmpty
        
    }
    // Whenever the username is filled in and the button is pressed, the game starts
    @IBAction func startButtonPressed(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        updateStartButton()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    // Whenever the game is finished, the user has the possibilty to unwind to the beginning of the game
    @IBAction func unwindToStartScreen(segue: UIStoryboardSegue){
        if segue.identifier == "DismissGame" {
            userNameField.text = ""
            
        }
    }
    // The username and initial score is passed on to the next QuestionViewcontroller so the score can be updated
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "GameStartingSegue" {
            let navViewController = segue.destination as! UINavigationController
            let questionViewController = navViewController.topViewController as! QuestionViewController
            highScoreStorage = HighScore(name: userNameField.text!, score: "0")
            questionViewController.highScore = highScoreStorage
            
            
        }
    }
}
