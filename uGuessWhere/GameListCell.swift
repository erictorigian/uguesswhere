//
//  GameListCell.swift
//  uGuessWhere
//
//  Created by Eric Torigian on 12/2/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit

class GameListCell: UITableViewCell {

	@IBOutlet weak var gameThumbnail: UIImageView!
	@IBOutlet weak var gameNameLabel: UILabel!
	@IBOutlet weak var gameOwnerLabel: UILabel!
	@IBOutlet weak var gameStartTimeLabel: UILabel!
	@IBOutlet weak var numberOfGuessesLabel: UILabel!
    @IBOutlet weak var solvedLabel: UILabel!
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	func configureCell(game: Game) {
		self.gameNameLabel.text = game.gameName
		self.gameOwnerLabel.text = game.gameOwner
		self.numberOfGuessesLabel.text = String(game.numberOfGuesses)
		self.gameStartTimeLabel.text = game.gameStartTime
		if game.gameStatus == "solved" {
           solvedLabel.isHidden = false
        } else {
            solvedLabel.isHidden = true
        }
	}
	
}

