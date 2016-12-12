//
//  Game.swift
//  uGuessWhere
//
//  Created by Eric Torigian on 12/6/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import Foundation
import Firebase

class Game {
	//MARK: - private internal variables
	private var _gameName: String
	private var _gameOwner: String
	private var _gameStartTime: Double
	private var _numberOfGuesses: Int
	private var _gameStatus: String
	
	//MARK: - getter/setters
	var gameName: String {
		return _gameName
	}
	
	var gameOwner: String {
		return _gameOwner
	}
	
	var gameStartTime: String {
		let date = Date(timeIntervalSince1970: _gameStartTime)
		let dateStringFormatter = DateFormatter()
		dateStringFormatter.dateFormat = "MMM dd YYYY hh:mm a"
		return dateStringFormatter.string(from: date)
	}
	
	var numberOfGuesses: Int {
		return _numberOfGuesses
	}
	
	var gameStatus: String {
		return _gameStatus
	}
	
	//MARK: - Initalizers
	init(snapshot: FIRDataSnapshot) {
		self._gameName = (snapshot.value as? NSDictionary)?["gameName"] as! String
		self._gameOwner = (snapshot.value as? NSDictionary)?["gameOwner"] as! String
		self._gameStartTime = (snapshot.value as? NSDictionary)?["gameStartTime"] as! Double
		self._numberOfGuesses = (snapshot.value as? NSDictionary)?["numberOfGuesses"] as! Int
		self._gameStatus = (snapshot.value as? NSDictionary)?["gameStatus"] as! String
	}
    
    
	
	
}
