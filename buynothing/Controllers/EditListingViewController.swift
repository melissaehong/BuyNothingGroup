//
//  EditListingViewController.swift
//  buynothing
//
//  Created by Annie Ton-Nu on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

class EditListingViewController: UIViewController {
    @IBOutlet weak var listingTitle: UITextField!
    @IBOutlet weak var listingDescription: UITextView!
    @IBOutlet weak var listingImage: UIImageView!

    var listing: Listing!

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        setInputFieldValues()
        setupCancelButton()
    }

    /// Set the view's input fields with the values from the
    /// listing property on the controller object
    func setInputFieldValues() {
        listingTitle.text = listing.title
        listingDescription.text = listing.descriptionText
        listingImage.image = listing.image
    }

    /// When the cancel button is pressed, dismiss the controller and
    /// set the tab bar to the home view controller
    func cancelButtonPressed() {
        let homeViewControllerTabBarIndex = 0
        dismiss(animated: true) {
            self.tabBarController?.selectedIndex = homeViewControllerTabBarIndex
        }
    }

    /// Build and set a cancel button to replace the navigation bar's default
    /// "back" button.
    func setupCancelButton() {
        // hide the default back button
        navigationItem.setHidesBackButton(true, animated: false)

        // build a cancel button with an "x" icon
        let cancelButton = UIButton(frame: .init(x: 0, y: 0, width: 25, height: 25))
        cancelButton.setImage(#imageLiteral(resourceName: "close"), for: .normal)

        // when this button is pressed, execute the given callback
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)

        // place the cancel button on the nav bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
    }

    /// When the save button is pressed, save the values from the input fields
    /// in the view to the listing object in memory, then persist the listing 
    /// object to CloudKit.
    @IBAction func saveButtonPressed(_ sender: Any) {
        listing.title = listingTitle.text ?? ""
        listing.descriptionText = listingDescription.text ?? ""
        listing.image = listingImage.image

        CloudKitFacade.shared.saveListing(listing) { (record) in
            if record == nil {
                // TODO: prompt user with error
            }
        }

        dismiss(animated: true, completion: nil)
    }
}
