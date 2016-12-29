//
//  DataService.swift
//  iWasHere
//
//  Created by Eric Torigian on 10/27/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import Foundation
import Firebase

//Global Firebase References
let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()


class DataService {
	//singleton database reference
	static let ds = DataService()
	
	//Firebase References
	private var _REF_BASE = DB_BASE
	private var _REF_USERS = DB_BASE.child("users")
	private var _REF_GAMES = DB_BASE.child("games")
	private var _REF_PLACE_IMAGE_STORAGE = STORAGE_BASE.child("placeImages")
	
	//class variable for save to database function
	var imageURL: String!
	
	//Public Getter
	var REF_BASE: FIRDatabaseReference {
		return _REF_BASE
	}
	
	var REF_USERS: FIRDatabaseReference {
		return _REF_USERS
	}
	
	var REF_GAMES: FIRDatabaseReference {
		return _REF_GAMES
	}
	
	var REF_PLACE_IMAGE_STORAGE: FIRStorageReference {
		return _REF_PLACE_IMAGE_STORAGE
	}
	
	
	//Database functions
	func createFirebaseDBUser(uid: String, userData: Dictionary<String, String> ) {
		REF_USERS.child(uid).updateChildValues(userData)
	}
	
		
	
}
