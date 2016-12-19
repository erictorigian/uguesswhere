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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("detail: \(game)")
        gameNameLabel.title = game.gameName
    }

}
