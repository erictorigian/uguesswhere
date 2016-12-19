//
//  GameListTableViewController.swift
//  uGuessWhere
//
//  Created by Eric Torigian on 12/2/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Firebase

class GameListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet var tableView: UITableView!
	var availableGames = [Game]()
	

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
		tableView.dataSource = self
		
		DataService.ds.REF_GAMES.observe(.value, with: { snapshot in
			self.availableGames = []
			
			if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
				for snap in snapshot {
					let newGame = Game(snapshot: snap)
					self.availableGames.append(newGame)
				}
			}
			
			self.tableView.reloadData()
			
		})
		
		
    }
	
	//MARK: - tableview functions
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return availableGames.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: KEY_AVAILABLE_GAMES_CELL) as? GameListCell {
			cell.configureCell(game: availableGames[indexPath.row])
			return cell
		} else {
			let cell = GameListCell()
			cell.configureCell(game: availableGames[indexPath.row])
			return cell
		}

	}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //MARK: - segue override
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE_SHOW_GAME_DETAIL {
            let destinationVC = segue.destination as! GameDetailViewController
            let indexPath = tableView.indexPathForSelectedRow!
            destinationVC.game = availableGames[indexPath.row]
        }
    }
	
}
