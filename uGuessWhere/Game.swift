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
	private var _image1URL: String
	private var _image2URL: String
	private var _image3URL: String

	
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
	
	var image1URL: String {
		return _image1URL
		
	}
	
	var image2URL: String {
		return _image2URL
	}

	var image3URL: String {
		return _image3URL
		
	}
	
	
	//MARK: - Initalizers
	init(snapshot: FIRDataSnapshot) {
		self._gameName = (snapshot.value as? NSDictionary)?["gameName"] as! String
		self._gameOwner = (snapshot.value as? NSDictionary)?["gameOwner"] as! String
		self._gameStartTime = (snapshot.value as? NSDictionary)?["gameStartTime"] as! Double
		self._numberOfGuesses = (snapshot.value as? NSDictionary)?["numberOfGuesses"] as! Int
		self._gameStatus = (snapshot.value as? NSDictionary)?["gameStatus"] as! String
		self._image1URL = (snapshot.value as? NSDictionary)?["photo1"] as! String
		self._image2URL = (snapshot.value as? NSDictionary)?["photo2"] as! String
		self._image3URL = (snapshot.value as? NSDictionary)?["photo3"] as! String
	}
	
	init(gameName: String, gameOwner: String, gameStartTime: Double, image1URL: String, image2URL: String, image3URL: String) {
		self._gameName = gameName
		self._gameOwner = gameOwner
		self._gameStartTime = gameStartTime
		self._gameStatus = "new"
		self._numberOfGuesses = 0
		self._image1URL = image1URL
		self._image2URL = image2URL
		self._image3URL = image3URL
	}
	
	//MARK: - convert functions
	func toAnyObject() -> [String: AnyObject] {
		var gameDict: [String: AnyObject]
		gameDict = ["gameName": _gameName as AnyObject,
		            "gameOwner": _gameOwner as AnyObject,
		            "gameStartTime": _gameStartTime as AnyObject,
		            "numberOfGuesses": _numberOfGuesses as AnyObject,
					"gameStatus": _gameStatus as AnyObject,
					"photo1": _image1URL as AnyObject,
					"photo2": _image2URL as AnyObject,
					"photo3": _image3URL as AnyObject]
		
		return gameDict as [String : AnyObject]
	}

	
	
	
}
