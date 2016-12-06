//
//  SignInViewController.swift
//  iWasHere
//
//  Created by Eric Torigian on 10/27/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper
import FBSDKCoreKit
import FBSDKLoginKit
import MapKit

class SignInViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet weak var usernameField: TextFieldLayout!
	@IBOutlet weak var passwordField: TextFieldLayout!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		
		if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
			performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
		}
	}
	
	//keyboard show
	func textFieldDidBeginEditing(_ textField: UITextField) {
		moveTextField(textField: textField, moveDistance: -250, up: true)
	}
	
	//keyboard hidden
	func textFieldDidEndEditing(_ textField: UITextField ) {
		moveTextField(textField: textField, moveDistance: 250, up: false)
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	
	@IBAction func signInButtonPressed(_ sender: AnyObject) {
		if let email = usernameField.text , email != "", let password = passwordField.text , password != "" {
			FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
				var username = ""
				if let error = error {
					self.showErrorAlert("Login Error", msg: error.localizedDescription)
				} else {
					if let user = user {
						if let name = user.displayName {
							username = name
						} else {
							username = email
						}
						let userData = ["provider": user.providerID, "username": username]
						self.completeSignin(user.uid, userData: userData)
					}
				}
				
				self.usernameField.text = ""
				self.passwordField.text = ""
			})
			
		} else {
			showErrorAlert("Login Error", msg: "You must include both an email and password to login")
		}
		
	}
	
	@IBAction func signUpForNewAccountButton(_ sender: Any) {
	 if let email = usernameField.text, email != "", let password = passwordField.text, password != "" {
		FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {( user, error) in
			if let error = error {
				self.showErrorAlert("User Creation Error", msg: error.localizedDescription)
			} else {
				self.signInButtonPressed(self)
			}
		})
		}
		
	}
	
	@IBAction func facebookLoginButtonPressed(_ sender: AnyObject) {
		//authorize facebook
		let facebookLogin = FBSDKLoginManager()
		facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
			if let error = error {
				self.showErrorAlert("Facebook Authentication Error", msg: error.localizedDescription)
			} else if result?.isCancelled == true {
				self.showErrorAlert("Facebook Login Error", msg: "User cancelled authorization request")
			} else {
				let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
				self.firebaseAuth(credential)
				
			}
		}	}
	
	func firebaseAuth(_ credential: FIRAuthCredential) {
		FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
			if error != nil {
				self.showErrorAlert("Firebase authentication error", msg: (error?.localizedDescription)!)
			} else {
				if let user = user {
					let userData = ["provider": credential.provider, "username": user.displayName!]
					self.completeSignin(user.uid, userData: userData)
				}
			}
			
			
		})
	}
	
	func completeSignin(_ uid: String, userData: Dictionary<String, String>) {
		print("complete signin: \(userData)  \(uid)")
		DataService.ds.createFirebaseDBUser(uid: uid, userData: userData)
		KeychainWrapper.standard.set(uid, forKey: KEY_UID)
		performSegue(withIdentifier: SEGUE_LOGGED_IN, sender: nil)
		
	}
	
	func showErrorAlert(_ title: String, msg: String ) {
		let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert )
		let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
		let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		alert.addAction(action)
		alert.addAction(cancel)
		present(alert, animated: true, completion: nil)
	}
	
	func moveTextField(textField: UITextField, moveDistance: Int, up: Bool) {
		let moveDuration = 0.3
		let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
		
		UIView.beginAnimations("animateTextField", context: nil)
		UIView.setAnimationBeginsFromCurrentState(true)
		UIView.setAnimationDuration(moveDuration)
		self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
		UIView.commitAnimations()
		
	}
	
	
}
