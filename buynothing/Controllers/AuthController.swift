//
//  ViewController.swift
//  buynothing
//
//  Created by Jake Romer on 4/10/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit
import UIKit

class AuthController: UIViewController {
    @IBOutlet weak var splashImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setRandomlySelectedSplashImage()
    }

    func setRandomlySelectedSplashImage() {
        let numberOfSplashImagesAvailable = 11
        let rand = Int(arc4random_uniform(UInt32(numberOfSplashImagesAvailable - 1)))
        let splashImageName = "splash_\(rand + 1)"
        splashImage.image = UIImage(named: splashImageName)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if FBSDKAccessToken.current() != nil {
            performSegue(withIdentifier: UITabBarController.reuseID, sender: nil)
        } else {
            setFacebookLoginButtonOnScreen()
        }
    }

    func setFacebookLoginButtonOnScreen() {
        let screen = UIScreen.main.bounds.size
        let centerBottomQuarter = CGPoint(x: screen.width / 2.0, y: screen.height * 4 / 5.0)
        let facebookLoginButton = FBSDKLoginButton()
        facebookLoginButton.center = centerBottomQuarter
        view.addSubview(facebookLoginButton)
    }
    
    func dismissAuthController() {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
}
