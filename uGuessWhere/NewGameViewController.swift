//
//  NewGameViewController.swift
//  uGuessWhere
//
//  Created by Eric Torigian on 12/28/16.
//  Copyright © 2016 Eric Torigian. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	var pickerController: UIImagePickerController!
	var imageSelected = 1
	var image1Selected = false
	var image2Selected = false
	var image3Selected = false
	var game: Game!
	
	@IBOutlet weak var image1View: UIImageView!
	@IBOutlet weak var image2View: UIImageView!
	@IBOutlet weak var image3View: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		pickerController = UIImagePickerController()
		pickerController.allowsEditing = true
		pickerController.delegate = self
		
		
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
				print("image 1")
				
			case 2:
				self.image1Selected = true
				self.image2View.image = pickedImage
				print("image 2")
				
			case 3:
				self.image1Selected = true
				self.image3View.image = pickedImage
				print("image 3")
				
			default:
				print("default")
			}
			
			
		} else {
			print("no image selected")
		}
		
		pickerController.dismiss(animated: true, completion: nil)
		
	}
	
	
}
