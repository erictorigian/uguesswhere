//
//  GameDetailViewController.swift
//  uGuessWhere
//
//  Created by Eric Torigian on 12/8/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Firebase

class GameDetailViewController: UIViewController {
    
    var game: Game!
    
    @IBOutlet weak var gameNameLabel: UINavigationItem!
    @IBOutlet weak var gameOwnerLabel: UILabel!
    @IBOutlet weak var gameStartTimeLabel: UILabel!
    @IBOutlet weak var numberOfGuessesLabel: UILabel!
    @IBOutlet weak var gameStatusLabel: UILabel!
    @IBOutlet weak var difficultyLevelLabel: UILabel!
    @IBOutlet weak var photo1View: UIImageView!
    @IBOutlet weak var photo2View: UIImageView!
    @IBOutlet weak var photo3View: UIImageView!
    
    
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
        
        //process images
        if let img = GameListTableViewController.imageCache.object(forKey: game.image1URL as NSString) {
            photo1View.image = img
        } else {
            let ref = FIRStorage.storage().reference(forURL: game.image1URL)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: {(data, error) in
                if error != nil {
                    print("snapDetails unable to download image: \(error?.localizedDescription)")
                } else {
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.photo1View.image = img
                            GameListTableViewController.imageCache.setObject(img, forKey: self.game.image1URL as NSString)
                        }
                    }
                }
            })
        }
        
        if game.image2URL != "none" {
            if let img = GameListTableViewController.imageCache.object(forKey: game.image2URL as NSString) {
                photo2View.image = img
            } else {
                let ref = FIRStorage.storage().reference(forURL: game.image2URL)
                ref.data(withMaxSize: 2 * 1024 * 1024, completion: {(data, error) in
                    if error != nil {
                        print("snapDetails unable to download image: \(error?.localizedDescription)")
                    } else {
                        if let imgData = data {
                            if let img = UIImage(data: imgData) {
                                self.photo2View.image = img
                                GameListTableViewController.imageCache.setObject(img, forKey: self.game.image2URL as NSString)
                            }
                        }
                    }
                })
            }
            
        }
    
        if game.image3URL != "none" {
            if let img = GameListTableViewController.imageCache.object(forKey: game.image3URL as NSString) {
                photo3View.image = img
            } else {
                let ref = FIRStorage.storage().reference(forURL: game.image3URL)
                ref.data(withMaxSize: 2 * 1024 * 1024, completion: {(data, error) in
                    if error != nil {
                        print("snapDetails unable to download image: \(error?.localizedDescription)")
                    } else {
                        if let imgData = data {
                            if let img = UIImage(data: imgData) {
                                self.photo3View.image = img
                                GameListTableViewController.imageCache.setObject(img, forKey: self.game.image3URL as NSString)
                            }
                        }
                    }
                })
            }
            
        }
    }
    
}
