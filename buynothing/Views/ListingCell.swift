//
//  ListingCell.swift
//  buynothing
//
//  Created by Jake Romer on 4/11/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

class ListingCell: UICollectionViewCell {
    @IBOutlet weak var listingMainImage: RoundedEdgeImageView!
    @IBOutlet weak var listingTitle: UILabel!

    var listing: Listing! {
        didSet {
            listingTitle.text = listing.title
            listingMainImage.image = listing.image
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
