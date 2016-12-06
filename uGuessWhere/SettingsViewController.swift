//
//  SettingsViewController.swift
//  iWasHere
//
//  Created by Eric Torigian on 11/3/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class SettingsViewController: UIViewController {
	
	@IBOutlet weak var userIDField: UITextField!
	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var usernameField: UITextField!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let user = FIRAuth.auth()?.currentUser {
			let name = user.displayName
			let email = user.email
			//            let photoUrl = user.photoURL
			let uid = user.uid;
			
			usernameField.text = name
			emailField.text = email
			userIDField.text = uid
			
			//            let imageUrl = String(describing: photoUrl!)
			//            networkingServices.storeageBaseRef.reference(forURL: imageUrl).data(withMaxSize: 1 * 1024 * 1024, completion: { (data, error) in
			//                if  let error = error {
			//                    print("user profile image error: \(error.localizedDescription)")
			//                } else {
			//                    if let data = data {
			//                        self.userImage.image = UIImage(data: data)
			//                    }
			//                }
			//            })
			//
			
		} else {
			usernameField.text = "Not logged in"
			emailField.text = "Not available"
			userIDField.text = "Not assigned"
			
		}
	}
	
	
	@IBAction func logOutButtonPressed(_ sender: AnyObject) {
		if FIRAuth.auth()?.currentUser != nil {
			do {
				try FIRAuth.auth()?.signOut()
				KeychainWrapper.standard.removeObject(forKey: KEY_UID)
				let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
				self.present(vc, animated: true, completion: nil)
				
			} catch let error as NSError {
				print("logout error: \(error.code)")
			}
		}
		
	}
	
}
