//
//  ProfileViewController.swift
//  buynothing
//
//  Created by A Cahn on 4/11/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

// TODO:
// - Change current request (which just queries for all listings) to a request for the current user's favorites
// - Implement switching of requests based on segment control selection (favorites/offered/accepted)
// - Implement didSelectItemAt (see below) -- segue to listing detail view controller
// - Set user avatar image based on the current user's info (dependent on getting facebook data)
// - Implement pull to refresh
// - Paginate results of queries

class ProfileViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    var refreshControl: UIRefreshControl!

    var listings = [Listing]() {
        didSet { collectionView.reloadData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        let listingCell = UINib(nibName: ListingCell.reuseID, bundle: nil)
        collectionView.register(listingCell, forCellWithReuseIdentifier: ListingCell.reuseID)
        collectionView.collectionViewLayout = GalleryViewLayout()

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadListings), for: .valueChanged)
        collectionView.addSubview(refreshControl)

    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        loadListings()
    }

    func loadListings() {
        Listing.listAll { (listings) in
            guard let listings = listings else { return }
            if listings.isEmpty {
                print("no results")
                // TODO: query returned no results
            }
            self.listings = listings
            self.loadingIndicator.stopAnimating()
        }

       stopRefresher()          // Call this to stop refresher
    }

    func stopRefresher() {
        refreshControl?.endRefreshing()
    }

}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listings.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListingCell.reuseID, for: indexPath) as! ListingCell
        cell.listing = listings[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected the cell at index \(indexPath.row)")
        // TODO: segue to listing detail view controller, setting the selected listing
    }
}
