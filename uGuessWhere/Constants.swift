//
//  Constants.swift
//  iWasHere
//
//  Created by Eric Torigian on 10/27/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import Foundation
import UIKit

let SHADOW_COLOR: CGFloat = 157.0/255.0

//Keys
let KEY_UID = "uid"

//Cells
let KEY_SAVED_LOC_CELL = "savedPlacesCell"
let KEY_AVAILABLE_GAMES_CELL = "gamesCell"


//Segues
let SEGUE_LOGGED_IN = "loggedIn"
let SEGUE_SHOW_GAME_DETAIL = "showGameDetail"
let SEGUE_SHOW_PROFILE = "showProfile"
let SEGUE_SHOW_AVAILABLE_GAMES = "showAvailableGames"


//Status codes
let STATUS_ACCOUNT_NONEXISTS = 17011
let STATUS_INVALID_PWD = 17009
let STATUS_INVALID_EMAIL = 17999
let STATUS_ACCOUNT_DISABLED = 17005
