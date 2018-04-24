//
//  AddListingViewController.swift
//  buynothing
//
//  Created by Annie Ton-Nu on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

class AddListingViewController: UIViewController {
    var imagePicker = UIImagePickerController()
    var newListing: Listing?
    var imagePickWasCancelled: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureImagePicker()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if imagePickWasCancelled {
            imagePickWasCancelled = false
            tabBarController?.selectedIndex = 0
        } else if let newListing = newListing {
            // if an image was selected / a new listing was created,
            // segue to the edit detail view controller
            performSegue(withIdentifier: EditListingViewController.reuseID, sender: newListing)
        } else {
            // if beginning the add listing flow for the first time,
            // present the image picker
            present(imagePicker, animated: true)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == EditListingViewController.reuseID,
            let controller = segue.destination as? EditListingViewController,
            let listing = sender as? Listing {
            controller.listing = listing
            return
        }
    }
}

extension AddListingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func configureImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
        } else if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        } else {
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum)!
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.newListing = Listing()

        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            newListing?.image = image
        } else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            newListing?.image = image
        }

        newListing?.user = User.testUser
        imagePicker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickWasCancelled = true
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
