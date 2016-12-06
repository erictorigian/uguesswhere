//
//  TextFieldLayout.swift
//  iWasHere
//
//  Created by Eric Torigian on 10/27/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit

class TextFieldLayout: UITextField {

	override func awakeFromNib() {
		layer.cornerRadius = 25
		clipsToBounds = true
	}
}
