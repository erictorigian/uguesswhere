//
//  NewGameViewController.swift
//  uGuessWhere
//
//  Created by Eric Torigian on 12/28/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class NewGameViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	
    let locationManager = CLLocationManager()
    
    var pickerController: UIImagePickerController!
	var username = ""
	var imageSelected = 1
	var image1Selected = false
	var image2Selected = false
	var image3Selected = false
	var gameRef: FIRDatabaseReference!
	var game: Game!
	
	@IBOutlet weak var image1View: UIImageView!
	@IBOutlet weak var image2View: UIImageView!
	@IBOutlet weak var image3View: UIImageView!
	@IBOutlet weak var gameNameLabel: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		pickerController = UIImagePickerController()
		pickerController.allowsEditing = true
		pickerController.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestLocation()
        }
		
		DataService.ds.REF_USERS.child(uid).observeSingleEvent(of: .value, with: {(snapshot) in
			let value = snapshot.value as? NSDictionary
			self.username = value?["username"] as! String })
		
		
	}
	
	//MARK: - IBActions
	
	@IBAction func saveButtonPressed(_ sender: Any) {
		guard let gameName = gameNameLabel.text, gameName != "" else {
			self.showErrorAlert("Save Game Error", msg: "Every game needs a name")
			return
		}
		
		guard let image1 = image1View.image, image1Selected == true else {
			self.showErrorAlert("Save Game Error", msg: "Every game needs at least one image")
			return
		}
		
		
		//prepare first image and push to storage
		if let imageData = UIImageJPEGRepresentation(image1, 0.2) {
			let imageUID = NSUUID().uuidString
			let imageMetadata = FIRStorageMetadata()
			imageMetadata.contentType = "image/jpg"
			
			DataService.ds.REF_PLACE_IMAGE_STORAGE.child(imageUID).put(imageData, metadata: imageMetadata) { (metadata, error) in
				if let error = error {
					print("error uploading image \(error.localizedDescription)")
				} else {
					//save game with first image
					let imageURL = metadata?.downloadURL()?.absoluteString
					self.gameRef = DataService.ds.REF_GAMES.childByAutoId()
					let gameStartTime = NSTimeIntervalSince1970
					
					let game = Game(gameName: gameName,
					                gameOwner: self.username,
					                gameStartTime: gameStartTime,
					                image1URL: imageURL!,
					                image2URL: "none",
					                image3URL: "none")
					
					self.gameRef.setValue(game.toAnyObject())
					
				}
			}
		}
		
		//if there is an image2 save and append the url
		if image2Selected == true {
			if let imageData = UIImageJPEGRepresentation(self.image2View.image!, 0.2) {
				let imageUID = NSUUID().uuidString
				let imageMetadata = FIRStorageMetadata()
				imageMetadata.contentType = "image/jpg"
				
				DataService.ds.REF_PLACE_IMAGE_STORAGE.child(imageUID).put(imageData, metadata: imageMetadata) { (metadata, error) in
					if let error = error {
						print("error uploading image \(error.localizedDescription)")
					} else {
						let imageURL = metadata?.downloadURL()?.absoluteString
						let updateValues = ["photo2": imageURL]
						self.gameRef.updateChildValues(updateValues)
					}
					
				}
			}
			
		}
		
		//if there is an image3 save and append the url
		if image2Selected == true {
			if let imageData = UIImageJPEGRepresentation(self.image3View.image!, 0.2) {
				let imageUID = NSUUID().uuidString
				let imageMetadata = FIRStorageMetadata()
				imageMetadata.contentType = "image/jpg"
				
				DataService.ds.REF_PLACE_IMAGE_STORAGE.child(imageUID).put(imageData, metadata: imageMetadata) { (metadata, error) in
					if let error = error {
						print("error uploading image \(error.localizedDescription)")
					} else {
						let imageURL = metadata?.downloadURL()?.absoluteString
						let updateValues = ["photo3": imageURL]
						self.gameRef.updateChildValues(updateValues)
					}
					
				}
			}
			
		}
		
		_ = self.navigationController?.popToRootViewController(animated: true)
		
	}
	
	@IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
		if let imageNumber = sender.view?.tag {
			self.imageSelected = imageNumber
		} else {
			self.imageSelected = 1
		}
		
		let alertController = UIAlertController(title: "Choose a Picture", message: "Choose your source for your picture", preferredStyle: .actionSheet)
		
		let cameraAction = UIAlertAction(title: "Camera", style: .default) { (UIAlertAction) in
			
			self.pickerController.sourceType = .camera
			self.pickerController.cameraCaptureMode = .photo
			self.present(self.pickerController, animated: true, completion: nil)
			
		}
		
		let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (UIAlertAction) in
			
			self.pickerController.sourceType = .photoLibrary
			self.present(self.pickerController, animated: true, completion: nil)
			
		}
		
		let savedPhotosAlbumAction = UIAlertAction(title: "Saved Photos Album", style: .default) { (UIAlertAction) in
			
			self.pickerController.sourceType = .savedPhotosAlbum
			self.present(self.pickerController, animated: true, completion: nil)
			
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil )
		
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			alertController.addAction(cameraAction)
		}
		
		alertController.addAction(photoLibraryAction)
		alertController.addAction(savedPhotosAlbumAction)
		alertController.addAction(cancelAction)
		
		
		
		present(alertController, animated: true, completion: nil)
		
		
	}
	
	//MARK: - ImagePicker Delegate Functions
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
			let pickedImage = image
			switch self.imageSelected {
			case 1:
				self.image1Selected = true
				self.image1View.image = pickedImage
				
			case 2:
				self.image2Selected = true
				self.image2View.image = pickedImage
				
			case 3:
				self.image3Selected = true
				self.image3View.image = pickedImage
				
			default:
				print("default")
			}
			
			
		} else {
			print("no image selected")
		}
		
		pickerController.dismiss(animated: true, completion: nil)
		
	}
	
	//MARK: - support functions
	func showErrorAlert(_ title: String, msg: String) {
		let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert )
		let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
    
    //MARK: - corelocation delegate functions
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("did update location")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("corelocation did fail with error")
    }
}

