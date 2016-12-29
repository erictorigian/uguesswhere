//
//  GameDetailViewController.swift
//  uGuessWhere
//
//  Created by Eric Torigian on 12/8/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit

class GameDetailViewController: UIViewController {

    var game: Game!
    
    @IBOutlet weak var gameNameLabel: UINavigationItem!
    @IBOutlet weak var gameOwnerLabel: UILabel!
    @IBOutlet weak var gameStartTimeLabel: UILabel!
    @IBOutlet weak var numberOfGuessesLabel: UILabel!
    @IBOutlet weak var gameStatusLabel: UILabel!
    @IBOutlet weak var difficultyLevelLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameNameLabel.title = game.gameName
        
        gameOwnerLabel.text = game.gameOwner
        gameStartTimeLabel.text = game.gameStartTime
        gameStatusLabel.text = game.gameStatus
        numberOfGuessesLabel.text = String(game.numberOfGuesses)
        
        switch game.numberOfGuesses {
        case 0..<10:
            difficultyLevelLabel.text = "Easy"
            difficultyLevelLabel.textColor = UIColor.green
        case 11..<20:
            difficultyLevelLabel.text = "Medium"
            difficultyLevelLabel.textColor = UIColor.yellow
        default:
            difficultyLevelLabel.text = "Hard"
            difficultyLevelLabel.textColor = UIColor.red
         }
    }

}
