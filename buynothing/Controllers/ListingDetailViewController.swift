//
//  ListingDetailViewController.swift
//  buynothing
//
//  Created by Annie Ton-Nu on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

class ListingDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var listingTitle: UILabel!
    @IBOutlet weak var listingLocation: UILabel!

    var listing: Listing!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = listing.image
        listingTitle.text = listing.title
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ListingDetailMoreInfoViewController" {
            let destination = segue.destination as? ListingDetailMoreInfoViewController
            destination?.selectedListing = self.listing
        }
    }
    
    @IBAction func moreInfoButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ListingDetailMoreInfoViewController", sender: nil)
        
    }
    
    @IBAction func closeButtonWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
